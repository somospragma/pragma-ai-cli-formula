class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.2-dev/pragma-ai-cli_1.3.2-dev_darwin_arm64.tar.gz"
      sha256 "6fb1610ccc156e32c1ac28f446be177ce68c18ef17196165722ab3aac2d37f38"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.2-dev/pragma-ai-cli_1.3.2-dev_darwin_amd64.tar.gz"
      sha256 "7468399f2538605c3ce6a3b257443a6058be94e87b9a39537cad253a5559dddf"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.2-dev/pragma-ai-cli_1.3.2-dev_linux_arm64.tar.gz"
      sha256 "80bc77319d6ad1963ddff85a86f391d359e5dd1563a24ef75bc53a50ba52c916"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.2-dev/pragma-ai-cli_1.3.2-dev_linux_amd64.tar.gz"
      sha256 "81e84a0af5777d382baa6c61045025fcf3a60717c8fff91b8689f6ca00644dfb"
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
