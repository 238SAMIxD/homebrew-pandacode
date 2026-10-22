# homebrew-pandacode

🍺 Official Homebrew tap for PandaCode

A Homebrew Cask for [PandaCode](https://github.com/aicodeking/pandacode), a native desktop workspace for coding agents.

## Install

```sh
brew tap aicodeking/pandacode
brew install --cask pandacode
```

Or install the cask in one command:

```sh
brew install --cask aicodeking/pandacode/pandacode
```

The cask selects the native Apple silicon or Intel DMG for the version pinned in the cask; its version and SHA-256 values are automatically refreshed for each upstream release. Each checksum comes from the matching `.sha256` release asset. PandaCode requires macOS 12 Monterey or later and updates itself after installation. The release is ad-hoc signed; if Gatekeeper blocks the first launch, choose **Open Anyway** in System Settings > Privacy & Security.

## Linux AppImage

Homebrew Casks install macOS applications. For Linux, PandaCode publishes official x86_64 and aarch64 AppImages on the [latest release](https://github.com/aicodeking/pandacode/releases/latest). Download the matching AppImage and its `.sha256` file, then verify and run it:

```sh
arch=x86_64 # use aarch64 on 64-bit ARM Linux
asset="PandaCode-Linux-${arch}.AppImage"
base="https://github.com/aicodeking/pandacode/releases/latest/download"
curl -fLO "$base/$asset" "$base/$asset.sha256"
sha256sum -c "$asset.sha256"
chmod +x "$asset"
"./$asset"
```

The AppImage contains the Linux application and is not installed by the macOS cask. If it cannot start because FUSE is unavailable, install your distribution's FUSE 2 compatibility package.

## Upstream metadata

- Description: “PandaCode: a calm desktop workspace for coding agents.”
- License: the [PandaCode License](https://github.com/aicodeking/pandacode/blob/main/LICENSE), an MIT license with an additional fork-attribution requirement. This custom license has no standard SPDX list identifier; its SPDX custom reference is `LicenseRef-PandaCode`.
- Releases: [PandaCode releases](https://github.com/aicodeking/pandacode/releases)

Homebrew Casks do not provide a license metadata field or a `test do` block. CI therefore audits the cask and installs it into a temporary Applications directory, then checks the installed bundle identifier.

## Updating the cask

The tap listens for a `pandacode-release` repository dispatch, fetches each macOS DMG's `.sha256` file, updates `version` and both architecture-specific checksums, and commits the cask update. The upstream release workflow should send this event after publishing a release. Configure a `HOMEBREW_TAP_TOKEN` Actions secret in `aicodeking/pandacode` using a token with `contents: write` access to this tap. The cask uses versioned release URLs so Homebrew can verify each download against its pinned checksum; Linux AppImages remain available through `releases/latest/download`.
