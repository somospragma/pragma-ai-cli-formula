class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.2.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.1-dev/pragma-ai-cli_1.2.1-dev_darwin_arm64.tar.gz"
      sha256 "167b3b4fb285fb5c7c6fb5b6ba6b33e4247e1e52995d15c6b14c47fab814f273"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.1-dev/pragma-ai-cli_1.2.1-dev_darwin_amd64.tar.gz"
      sha256 "c4362c7bd9d16758c553c9ae293eacfffe8a05bbbf5a87cea733957a7a072990"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.1-dev/pragma-ai-cli_1.2.1-dev_linux_arm64.tar.gz"
      sha256 "87f70368455b6d0c7c888c8f77bd2cf147302ae8e0859810db01928fd8af56af"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.1-dev/pragma-ai-cli_1.2.1-dev_linux_amd64.tar.gz"
      sha256 "18761caabf26426023c7a441a1ff680ed25d3002b0b7c42600706fdc0da797be"
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
