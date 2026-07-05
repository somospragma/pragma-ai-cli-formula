class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.3-dev/pragma-ai-cli_1.0.3-dev_darwin_arm64.tar.gz"
      sha256 "dc1555470758c5528dc0e88e01368414e65015eac1eba7b6d423cb66f8099f68"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.3-dev/pragma-ai-cli_1.0.3-dev_darwin_amd64.tar.gz"
      sha256 "d571f3e8ae7eea715268478176e7c4f14438b3ee83cdc5e31a1814a053619f98"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.3-dev/pragma-ai-cli_1.0.3-dev_linux_arm64.tar.gz"
      sha256 "1f5ba7aa02fbb17085a9f73cb65d0fe6ebb7c522458ce8dfc87936f6031be9b5"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.3-dev/pragma-ai-cli_1.0.3-dev_linux_amd64.tar.gz"
      sha256 "5c5469ad28badf05549edd5cd24b79a5d57d79ff826b4662b4951cf1debb7c6a"
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
