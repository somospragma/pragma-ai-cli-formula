class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.4.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.0-dev/pragma-ai-cli_1.4.0-dev_darwin_arm64.tar.gz"
      sha256 "af8db9104fe84f4be2dc0410181ae11472fc1387b9f2d4bc9abac9201ecb263d"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.0-dev/pragma-ai-cli_1.4.0-dev_darwin_amd64.tar.gz"
      sha256 "b2bc59a765139d94ab347a17977874ea65dd2df944e44c41f900284e753e47c5"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.0-dev/pragma-ai-cli_1.4.0-dev_linux_arm64.tar.gz"
      sha256 "7366b3c9e9443a2854c9451a55e2267b5a7c751a8d37cc3a085570ac1842c95e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.0-dev/pragma-ai-cli_1.4.0-dev_linux_amd64.tar.gz"
      sha256 "6e2db1f7acda689d466d3b32e5ae4e49a38b5720f9fae73bec3794b462e96e81"
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
