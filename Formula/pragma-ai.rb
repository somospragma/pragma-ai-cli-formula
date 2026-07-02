class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.7-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_darwin_arm64.tar.gz"
      sha256 "83cc677f7388400595b65954926b0cee463f10606b86ade12654f4c19ab84c82"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_darwin_amd64.tar.gz"
      sha256 "4846d059032669c0f15871686fc626ab41518d6260e10f137794be7dd0263165"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_linux_arm64.tar.gz"
      sha256 "a552fdd016d2aac8bb5c4dac50db4e884263e4a62789c4de2af64257793909c0"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.7-dev/pragma-ai-cli_0.1.7-dev_linux_amd64.tar.gz"
      sha256 "5e703cca1c9a7c612d480bffdf909b66f7ea209a13a55f7f087dd873ebbc9fa4"
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
