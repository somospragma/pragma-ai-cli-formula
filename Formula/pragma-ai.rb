class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.6-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_arm64.tar.gz"
      sha256 "1bf2fc660be096c9cbdf1e53668b314fdb38f6fe360d24160c40aa94a4d137a3"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_amd64.tar.gz"
      sha256 "fba4a434cb071638b2f1ba9903df81d26c5fad114fa9f498abaa279d776d9797"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_arm64.tar.gz"
      sha256 "2d36b2758c6bd17772ef2bedbd5142f109b7e3b6bea99671133b6690b6ce530b"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_amd64.tar.gz"
      sha256 "e83ae13459c4dff8f91563e999e9b663653ba95d90c994c29907ea2c93bbf125"
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
