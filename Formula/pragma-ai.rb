class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.3"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.3/pragma-ai-cli_0.1.3_darwin_arm64.tar.gz"
      sha256 "d8ff251557dda5edf5ec1e609dc2b795944ffe610af74f114ca04b314473e670"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.3/pragma-ai-cli_0.1.3_darwin_amd64.tar.gz"
      sha256 "5d41efe31b3261fdaae2723ceee3673c12b03215bf7b45a66fae4dece8a45716"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.3/pragma-ai-cli_0.1.3_linux_arm64.tar.gz"
      sha256 "77fa650fdf7a8a731baecbf8a89e8400824230427a96e386aaf2156d91b16404"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.3/pragma-ai-cli_0.1.3_linux_amd64.tar.gz"
      sha256 "89481bcf4a1620bc2afd2c40e58685eeedb3a5be6a3df474bd468382e60fdb59"
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

      Background services have been configured to sync your assets every 4 hours.

      To get started, open a terminal and run:
        pragma-ai

      This will guide you through login and project setup.
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
