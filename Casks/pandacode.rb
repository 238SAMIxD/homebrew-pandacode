cask "pandacode" do
  arch arm: "arm64", intel: "x64"

  version "0.3.24"
  sha256 arm:   "98eb41c5e2215e0901762e121c6ff57cbd67e534083b364fe0747b9aac86b270",
         intel: "3f5c86e7e633b1d74dc3477c49c7e41047908516cb38ec01a91d80ca3305ea88"

  url "https://github.com/aicodeking/pandacode/releases/download/v#{version}/PandaCode-macOS-#{arch}.dmg"
  name "PandaCode"
  desc "Calm desktop workspace for coding agents"
  homepage "https://github.com/aicodeking/pandacode"

  auto_updates true
  depends_on macos: :monterey

  app "PandaCode.app"

  caveats do
    "If macOS cannot verify the app on first launch, choose Open Anyway in System Settings > Privacy & Security."
  end
end
