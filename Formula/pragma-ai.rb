class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.0-dev/pragma-ai-cli_1.0.0-dev_darwin_arm64.tar.gz"
      sha256 "72e2a8d6ce6da7a1ba9c72465f992eb5fc7611d1ae1f4568dd4116252d9608ab"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.0-dev/pragma-ai-cli_1.0.0-dev_darwin_amd64.tar.gz"
      sha256 "9a792a0bcb132d0b4698f71843b37873ae05d62f781ad327a08142b96764438c"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.0-dev/pragma-ai-cli_1.0.0-dev_linux_arm64.tar.gz"
      sha256 "d2705ec4219e2b9b03ca3de58b0594099b84f0c5f0d4b52321f8ed4140ceec6c"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.0-dev/pragma-ai-cli_1.0.0-dev_linux_amd64.tar.gz"
      sha256 "56af3324bd7b2b2bb98608cf706e92cae01d494fd2e6c7d1f7762fbb6301da2d"
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
