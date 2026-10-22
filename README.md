# homebrew-pandacode

🍺 Official Homebrew tap for PandaCode

A Homebrew Cask for [PandaCode](https://github.com/aicodeking/pandacode), a native desktop workspace for coding agents.

## Install

Set `OWNER` to the GitHub account that owns this tap. It is currently `238SAMIxD`; change this one value to `aicodeking` after the repository is transferred.

```sh
OWNER="238SAMIxD"
brew tap "$OWNER/pandacode"
brew install --cask pandacode
```

Or install the cask in one command:

```sh
OWNER="238SAMIxD"
brew install --cask "$OWNER/pandacode/pandacode"
```

The cask selects the native Apple silicon or Intel DMG. PandaCode requires macOS 12 Monterey or later and updates itself after installation. The release is ad-hoc signed; if Gatekeeper blocks the first launch, choose **Open Anyway** in System Settings > Privacy & Security.

## Upstream metadata

- Description: “PandaCode: a calm desktop workspace for coding agents.”
- License: the [PandaCode License](https://github.com/aicodeking/pandacode/blob/main/LICENSE), an MIT license with an additional fork-attribution requirement. This custom license has no standard SPDX list identifier; its SPDX custom reference is `LicenseRef-PandaCode`.
- Releases: [PandaCode releases](https://github.com/aicodeking/pandacode/releases)

Homebrew Casks do not provide a license metadata field or a `test do` block. CI therefore audits the cask and installs it into a temporary Applications directory, then checks the installed bundle identifier.
