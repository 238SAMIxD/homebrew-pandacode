# homebrew-pandacode

🍺 Official Homebrew tap for PandaCode

A cross-platform Homebrew Cask for [PandaCode](https://github.com/aicodeking/pandacode), a native desktop workspace for coding agents.

## Install

```sh
brew tap aicodeking/pandacode
brew install --cask pandacode
```

Or install the cask in one command:

```sh
brew install --cask aicodeking/pandacode/pandacode
```

The cask selects the matching release asset automatically: the Apple silicon or Intel DMG on macOS, and the aarch64 or x86_64 AppImage on Linux. It installs the Linux AppImage into `~/Applications/PandaCode.AppImage`; no manual download is needed. PandaCode requires macOS 12 Monterey or later on macOS and updates itself after installation. The macOS release is ad-hoc signed; if Gatekeeper blocks the first launch, choose **Open Anyway** in System Settings > Privacy & Security.

On Linux, launch the installed AppImage with:

```sh
"$HOME/Applications/PandaCode.AppImage"
```

If the AppImage cannot start because FUSE is unavailable, install your distribution's FUSE 2 compatibility package or set `APPIMAGE_EXTRACT_AND_RUN=1`.

## Upstream metadata

- Description: “PandaCode: a calm desktop workspace for coding agents.”
- License: the [PandaCode License](https://github.com/aicodeking/pandacode/blob/main/LICENSE), an MIT license with an additional fork-attribution requirement. This custom license has no standard SPDX list identifier; its SPDX custom reference is `LicenseRef-PandaCode`.
- Releases: [PandaCode releases](https://github.com/aicodeking/pandacode/releases)

Homebrew Casks do not provide a license metadata field or a `test do` block. CI audits the cask and smoke-tests the macOS app bundle and Linux AppImage.

## Updating the cask

The tap listens for a `pandacode-release` repository dispatch, fetches the macOS DMG and Linux AppImage `.sha256` files, updates the version and all four architecture-specific checksums, commits the cask update, and runs the tap tests. The upstream release workflow should send this event after publishing a release. Configure a `HOMEBREW_TAP_TOKEN` Actions secret in `aicodeking/pandacode` using a token with `contents: write` access to this tap. The cask uses versioned release URLs so Homebrew can verify each download against its pinned checksum.
