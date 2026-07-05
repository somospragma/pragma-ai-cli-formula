class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.4-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.4-dev/pragma-ai-cli_1.0.4-dev_darwin_arm64.tar.gz"
      sha256 "659ed2911d59f8b65853e4c8e36f821dcffa73d4bde4e3deeb90f050451650e1"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.4-dev/pragma-ai-cli_1.0.4-dev_darwin_amd64.tar.gz"
      sha256 "f010c9420e4a85ef56d3166e70b80d34b7105b56f7e37427f987118d6defb2b7"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.4-dev/pragma-ai-cli_1.0.4-dev_linux_arm64.tar.gz"
      sha256 "202633ff921cd5554b710a2ef31698780f414ad6c2c784bc67682c6c424c4fb7"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.4-dev/pragma-ai-cli_1.0.4-dev_linux_amd64.tar.gz"
      sha256 "c1dcf114b04abfb0011195507cde06bb2cc5af84cfd818b08aefd93294590ffd"
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
