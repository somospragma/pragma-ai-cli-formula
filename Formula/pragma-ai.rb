class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.7-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_darwin_arm64.tar.gz"
      sha256 "869e68eca13e84b5c5d97443d2b187dedeba8c0d0877431816c43df848bdd047"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_darwin_amd64.tar.gz"
      sha256 "0edc7056f3da3e6493689b332f18eddb679e4c147dc875f3da48a14802b56ca0"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_linux_arm64.tar.gz"
      sha256 "db914580a83e274ed14400f44f563c81cfe604562a10fc3cc4a71dcb8c7da334"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_linux_amd64.tar.gz"
      sha256 "803e503d194ce13bbed359612a3659ab2bdc85be79bc5e665d5edaf9695941f5"
    end
  end

  def install
    bin.install "pragma-ai"
    bin.install "pragma-ai-telemetry"
  end

  def post_install
    # Install background services (launchd agent for periodic sync)
    system "#{bin}/pragma-ai", "agent", "install"
  end

  def caveats
    <<~EOS
      Pragma AI has been installed successfully.

      Background services have been configured to sync your assets every 24 hours.

      To get started, open a terminal and run:
        pragma-ai

      This will guide you through login and project setup.
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
