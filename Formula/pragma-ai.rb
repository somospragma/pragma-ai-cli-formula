class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.2-dev/pragma-ai-cli_1.6.2-dev_darwin_arm64.tar.gz"
      sha256 "4b576fc14724369a7b930299fa8b8afd64775eeb28149da97af1fcfddeaf4c5d"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.2-dev/pragma-ai-cli_1.6.2-dev_darwin_amd64.tar.gz"
      sha256 "95519097557d1647823fe5cfafa2695277be200e20a447f9035aa835a53a0f3c"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.2-dev/pragma-ai-cli_1.6.2-dev_linux_arm64.tar.gz"
      sha256 "735fa5266e9c83e95dcc8f115c64632b0a21ae4fc641cfa4ad35f9ec483556ae"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.2-dev/pragma-ai-cli_1.6.2-dev_linux_amd64.tar.gz"
      sha256 "15c647774cdc76e0809c00073e801550d8c7fe0f6f45b61014450ff0f5cb3157"
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
