class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.2"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.2/pragma-ai-cli_1.6.2_darwin_arm64.tar.gz"
      sha256 "588345f2b44b0e300aca4ff67f09f6eeceb251a70c0e0f57a48ec481f3d1cc16"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.2/pragma-ai-cli_1.6.2_darwin_amd64.tar.gz"
      sha256 "86c2174402fe0fc512f57ad589dea2a7d4cd4b9870abf4076d80b0598ca9d058"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.2/pragma-ai-cli_1.6.2_linux_arm64.tar.gz"
      sha256 "36c1c14b24608302f71176a471ac9b20c79c3a2f0a1e6c69b083712de32511b9"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.2/pragma-ai-cli_1.6.2_linux_amd64.tar.gz"
      sha256 "5b3be97ce8f502ec81e03cc748d20bd6e2be2dec27f4a31411dfb7614afaaf43"
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
