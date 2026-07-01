class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_darwin_arm64.tar.gz"
      sha256 "a5a010d06ca7429a6136fe073f3e44af69e5b62eaece50f80e8bd3d371d9ebc1"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_darwin_amd64.tar.gz"
      sha256 "318785c71f9301c2627bf2207a692c7b725220fd56e556fe49c58ad66b83a14d"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_linux_arm64.tar.gz"
      sha256 "8a3894155d76675450b9bc8a5e0d5b8550263d99c0dd94d03b5bb727aed134a9"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_linux_amd64.tar.gz"
      sha256 "a11e0366e00d39bbc2297946574e94202fdc1a41a4207030e8a556faeeb1732c"
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
