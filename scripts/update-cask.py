#!/usr/bin/env python3
"""Update the PandaCode cask from a published GitHub release."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


REPOSITORY = "aicodeking/pandacode"
ASSETS = {
    "arm": "PandaCode-macOS-arm64.dmg",
    "intel": "PandaCode-macOS-x64.dmg",
}
VERSION_PATTERN = re.compile(r"\A\d+\.\d+\.\d+\Z")
CHECKSUM_PATTERN = re.compile(r"\A([0-9a-fA-F]{64})\s+\*?([^\s]+)\s*\Z")


def get_text(url: str) -> str:
    request = Request(url, headers={"User-Agent": "homebrew-pandacode-cask-updater"})
    with urlopen(request, timeout=30) as response:
        return response.read().decode("utf-8").strip()


def release_checksum(version: str, asset: str) -> str:
    url = (
        f"https://github.com/{REPOSITORY}/releases/download/v{version}/"
        f"{asset}.sha256"
    )
    content = get_text(url)
    match = CHECKSUM_PATTERN.fullmatch(content)
    if not match or match.group(2) != asset:
        raise ValueError(f"Unexpected checksum file contents for {asset}: {content!r}")
    return match.group(1).lower()


def main() -> int:
    if len(sys.argv) != 2 or not VERSION_PATTERN.fullmatch(sys.argv[1]):
        print("Usage: update-cask.py X.Y.Z", file=sys.stderr)
        return 2

    version = sys.argv[1]
    try:
        latest = json.loads(
            get_text(f"https://api.github.com/repos/{REPOSITORY}/releases/latest")
        )
        if latest.get("tag_name") != f"v{version}":
            print(
                f"Skipping stale release notification for v{version}; "
                f"latest release is {latest.get('tag_name', 'unknown')}.",
            )
            return 0

        checksums = {arch: release_checksum(version, asset) for arch, asset in ASSETS.items()}
    except (HTTPError, URLError, TimeoutError, ValueError, json.JSONDecodeError) as error:
        print(f"Could not read PandaCode release checksums: {error}", file=sys.stderr)
        return 1

    cask_path = Path(__file__).resolve().parents[1] / "Casks" / "pandacode.rb"
    contents = cask_path.read_text(encoding="utf-8")
    updated, version_count = re.subn(
        r'(?m)^  version "[^"\n]+"$',
        f'  version "{version}"',
        contents,
    )
    updated, checksum_count = re.subn(
        r'(?m)^  sha256 arm:\s+"[0-9a-f]{64}",\n'
        r'         intel: "[0-9a-f]{64}"$',
        f'  sha256 arm:   "{checksums["arm"]}",\n'
        f'         intel: "{checksums["intel"]}"',
        updated,
    )
    if version_count != 1 or checksum_count != 1:
        print("Could not find the expected version and SHA-256 stanzas in the cask.", file=sys.stderr)
        return 1

    if updated == contents:
        print(f"PandaCode cask is already current at v{version}.")
    else:
        cask_path.write_text(updated, encoding="utf-8")
        print(f"Updated PandaCode cask to v{version}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
