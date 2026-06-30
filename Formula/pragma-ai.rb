class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.4"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_darwin_arm64.tar.gz"
      sha256 "68dbab245c23905edd212325ed76d140e89f37958c93f379d644fcb1d98989fa"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_darwin_amd64.tar.gz"
      sha256 "ffc9366e83dd759af2e748d611a462a0f159c3a0186e371c79f9191ed8eb4400"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_linux_arm64.tar.gz"
      sha256 "a2891355776022d3d04191a7adb84ad68416859f785119f0bdacbcd46a03d5f7"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_linux_amd64.tar.gz"
      sha256 "bde6d378deaa9550bd7d9455469ba1ceaf852acbbc0db26880672e12363a3db6"
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
