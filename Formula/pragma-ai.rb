class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.0/pragma-ai-cli_0.1.0_darwin_arm64.tar.gz"
      sha256 "415a11e7aef1bac8b8501f28a1b2d63bdea433d911fe743b68beda05616837d8"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.0/pragma-ai-cli_0.1.0_darwin_amd64.tar.gz"
      sha256 "227631c011d1bf42f8afb78488b795e3a143675015646ee106b1556820e203f9"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.0/pragma-ai-cli_0.1.0_linux_arm64.tar.gz"
      sha256 "78b21bf466a0009a5b0fca3141ec72df3476449e0ee4d313d9d7a95f7b6e7e91"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.0/pragma-ai-cli_0.1.0_linux_amd64.tar.gz"
      sha256 "d2565658da6f5d8d4d6a2ca8bd47d948d1fa3ba1e716c51e6663c35fc76b69a9"
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
