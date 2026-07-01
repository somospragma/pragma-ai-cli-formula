class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.6-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_arm64.tar.gz"
      sha256 "6013a62b1488acd2de9bcd0471a4ef072cc08b6eadf9b434f5001afdc71e4dd4"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_amd64.tar.gz"
      sha256 "66608d4614969dd13e533a0e9e0d9078f34d054eaae0774ab95c272a03b645ec"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_arm64.tar.gz"
      sha256 "aa3d60d2283abf9e4003dfc53f68d762a0aa573a4c7fbb03d860deb6099fba63"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_amd64.tar.gz"
      sha256 "92d2a6f8ad8cfce03ae2366ca2bebfc417dbbf28297e874cca262fe9cf4e20f1"
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
