class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.4-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.4-dev/pragma-ai-cli_1.6.4-dev_darwin_arm64.tar.gz"
      sha256 "3dff667f85231073887d686ec51e720ec37d77aa880fc462dff98962fed0a1b9"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.4-dev/pragma-ai-cli_1.6.4-dev_darwin_amd64.tar.gz"
      sha256 "a69fc56f9d41607b438c53ebfed154a25e1bc842a188830212364be010c614fa"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.4-dev/pragma-ai-cli_1.6.4-dev_linux_arm64.tar.gz"
      sha256 "21c198512724b45f49920eaa89d74dd791bb5c7a7a5cf761fdc387fb1e487354"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.4-dev/pragma-ai-cli_1.6.4-dev_linux_amd64.tar.gz"
      sha256 "4c209ffca92222c7054d8c096648689154baab533bf364e49b7e0f8605a3792d"
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
