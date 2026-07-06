class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.1-dev/pragma-ai-cli_1.1.1-dev_darwin_arm64.tar.gz"
      sha256 "98bec5b5bad5c81fd3564916e24b076d1422e99288b18ede56fc550fe4f6c920"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.1-dev/pragma-ai-cli_1.1.1-dev_darwin_amd64.tar.gz"
      sha256 "e3357284645490a7777387e9086de47dc2818908c7a8cf70cd8d6050581ce6aa"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.1-dev/pragma-ai-cli_1.1.1-dev_linux_arm64.tar.gz"
      sha256 "f16b904e400942bfb4b678a59fda047664fd431dbdb436e56eb5ce1a8f526e5f"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.1-dev/pragma-ai-cli_1.1.1-dev_linux_amd64.tar.gz"
      sha256 "0e31cfe02daecaadf9859148834753a05142e2ef2cecf8ca3704b8b993794129"
    end
  end

  def install
    bin.install "pragma-ai"
    bin.install "pragma-ai-gui"
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

      Available commands:
        pragma-ai       — CLI (terminal)
        pragma-ai-gui   — GUI (interfaz gráfica)

      To get started, open a terminal and run:
        pragma-ai

      Or launch the graphical interface:
        pragma-ai-gui
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
