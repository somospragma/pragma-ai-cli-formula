class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.1-dev/pragma-ai-cli_1.0.1-dev_darwin_arm64.tar.gz"
      sha256 "86f4c77de1740b7b1dc5660a03eac1918cb0e2c29f40cc8811de8b58ece1652f"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.1-dev/pragma-ai-cli_1.0.1-dev_darwin_amd64.tar.gz"
      sha256 "88b577094ae07bae8e535b741f4cc30a76eb60b54597989a99fb47a5c74bd766"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.1-dev/pragma-ai-cli_1.0.1-dev_linux_arm64.tar.gz"
      sha256 "596cc24c3c40294bb48700757b5c7277fc01799137a3c6a2ae2d3721382e0f82"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.1-dev/pragma-ai-cli_1.0.1-dev_linux_amd64.tar.gz"
      sha256 "6a93954a168d035ae900220322ffd3cdded4db9e33c23af763b65590c81974ef"
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
