class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.3-dev/pragma-ai-cli_1.3.3-dev_darwin_arm64.tar.gz"
      sha256 "f292652571178241d3dd2a2374f3a81e2ed9d7b10e5730c4165add36c0b758ec"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.3-dev/pragma-ai-cli_1.3.3-dev_darwin_amd64.tar.gz"
      sha256 "bd6073493192ed73bf4d32f2495b0fe360a3dc01c896717a9a49138596951c11"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.3-dev/pragma-ai-cli_1.3.3-dev_linux_arm64.tar.gz"
      sha256 "320bc0417a6342797a73ba5e79e37170e3f49acac0aad8ca5e96fa3f0decd572"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.3-dev/pragma-ai-cli_1.3.3-dev_linux_amd64.tar.gz"
      sha256 "5ae39ebdd8cb56b1f0ab5bf649d1b9cb25c424f5ab9828df076ea819243f5436"
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
