class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "2.0.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/2.0.2-dev/pragma-ai-cli_2.0.2-dev_darwin_arm64.tar.gz"
      sha256 "0c032bdb37734096c52292920dc26e2aadaa78b8c521407690b2225afe62f21e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/2.0.2-dev/pragma-ai-cli_2.0.2-dev_darwin_amd64.tar.gz"
      sha256 "fc9b34eb3d2403a24d9f071b6fcb1b1a04c3532671bef8e3eb8bd3da5142e77e"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/2.0.2-dev/pragma-ai-cli_2.0.2-dev_linux_arm64.tar.gz"
      sha256 "e57bf5dec08a8bd2f69ad641e3c1a39b48301283093b3dc6054e91f532ded37b"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/2.0.2-dev/pragma-ai-cli_2.0.2-dev_linux_amd64.tar.gz"
      sha256 "79eedfd0bdce0a4b5644456bf3492d181a6166ce77567a5e6606a193581d8006"
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
