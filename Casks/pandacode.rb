cask "pandacode" do
  arch arm:   on_system_conditional(macos: "arm64", linux: "aarch64"),
       intel: on_system_conditional(macos: "x64", linux: "x86_64")
  os macos: "macOS", linux: "Linux"
  url_end = on_system_conditional(macos: "dmg", linux: "AppImage")

  version "0.3.26"
  sha256 arm:          "9628ec8eb4b07eacd21c428c46438e478ce7e1e38fd6a1145888cfc922157b12",
         intel:        "da6f2050180aac5ae51079c500725bcff358a4002744eaebf7f810d6279cc0d4",
         arm64_linux:  "77f55175fb968a612d0618a717a7e399abcb9586482bca26f0576bf88a6fb61e",
         x86_64_linux: "109784f9ccd0bdcaa751a13480ddd7c590f14c3debaced1cc4389f3661cc60c8"

  on_macos do
    depends_on macos: :monterey

    app "PandaCode.app"

    caveats do
      "If macOS cannot verify the app on first launch, choose Open Anyway in System Settings > Privacy & Security."
    end
  end
  on_linux do
    app_image "PandaCode-Linux-#{arch}.AppImage", target: "PandaCode.AppImage"
  end

  url "https://github.com/aicodeking/pandacode/releases/download/v#{version}/PandaCode-#{os}-#{arch}.#{url_end}"
  name "PandaCode"
  desc "Calm desktop workspace for coding agents"
  homepage "https://github.com/aicodeking/pandacode"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
end
