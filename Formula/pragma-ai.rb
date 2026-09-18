class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.6"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.6/pragma-ai-cli_1.7.6_darwin_arm64.tar.gz"
      sha256 "0e18c62a77465e94215d78c5da0762dd2aa5f6379df31f59be2a67d5e8f85cba"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.6/pragma-ai-cli_1.7.6_darwin_amd64.tar.gz"
      sha256 "c85cebaabe4b35ec57ad6cd21bbb1efc91622c8be7bb70bd0dc667e6678c31ef"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.6/pragma-ai-cli_1.7.6_linux_arm64.tar.gz"
      sha256 "ac503e1cc1834aba5f17391ec1d141f82b3e9632a5aaead1c6dee2b9bcad585a"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.6/pragma-ai-cli_1.7.6_linux_amd64.tar.gz"
      sha256 "4a50ca7c75dd57f4f14140dd855bc1b1458d04785b50ad265269a7e798420a7d"
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
    # Run one sync cycle immediately so every known project's IDE hooks and
    # assets pick up this version right away, instead of waiting for the
    # next scheduled run or IDE session.
    system "#{bin}/pragma-ai", "agent", "run"
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
