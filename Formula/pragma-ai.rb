class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_darwin_arm64.tar.gz"
      sha256 "cc1930a2dd8ca97f8fa5f2f0b32dcdf9891e568e740363f00926989469c5871d"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_darwin_amd64.tar.gz"
      sha256 "1afd882bc0d5f2952cd45104b395972e7e2cdf38196178d561c66fefdd67043b"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_linux_arm64.tar.gz"
      sha256 "97f21a03fb044f83992fac268167d0a9c4e5b9a6aa894548e1a01f9b8e0cb6b3"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_linux_amd64.tar.gz"
      sha256 "c683ff1a96c89f044dadb9576ff0f276d67376fe6f06a2eb9f892413f91ea067"
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
