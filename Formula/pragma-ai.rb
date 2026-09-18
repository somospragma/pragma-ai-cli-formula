class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.5-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.5-dev/pragma-ai-cli_1.7.5-dev_darwin_arm64.tar.gz"
      sha256 "7b03373b440b6a66f0a8f8cec9c0cd6e0db58a4096bae2db54900370f536173e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.5-dev/pragma-ai-cli_1.7.5-dev_darwin_amd64.tar.gz"
      sha256 "08501e99da41ae19bcae95a2d3d006ae68e94832754d349bf682bbebcd75f079"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.5-dev/pragma-ai-cli_1.7.5-dev_linux_arm64.tar.gz"
      sha256 "6f48283f50e5a0c83b2e832d43482dcc0fbf45572c29728b7c03a39feb0092fd"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.5-dev/pragma-ai-cli_1.7.5-dev_linux_amd64.tar.gz"
      sha256 "b17e43df75d8a602bde027d58ae0e12648f973235898c11b7e0ee8765ae9f7b1"
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
