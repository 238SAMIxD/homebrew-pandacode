cask "pandacode" do
  arch arm: "arm64", intel: "x64"

  version "0.3.25"
  sha256 arm:   "e57cfb0bbc2623ca864317dbbc1d75ac611d7d56e4443e6dc1053bad2950abd2",
         intel: "436c126f14cf2edd9b249748adb54339033ac3a2931600e870d772babf4efc0f"

  url "https://github.com/aicodeking/pandacode/releases/download/v#{version}/PandaCode-macOS-#{arch}.dmg"
  name "PandaCode"
  desc "Calm desktop workspace for coding agents"
  homepage "https://github.com/aicodeking/pandacode"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "PandaCode.app"

  caveats do
    "If macOS cannot verify the app on first launch, choose Open Anyway in System Settings > Privacy & Security."
  end
end
