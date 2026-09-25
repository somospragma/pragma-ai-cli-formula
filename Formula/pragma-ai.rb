class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.8.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.8.0-dev/pragma-ai-cli_1.8.0-dev_darwin_arm64.tar.gz"
      sha256 "cb0e2832660f0d17c6accce2e8d64d855eaf21fe5702dedc9c4e3688902ed888"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.8.0-dev/pragma-ai-cli_1.8.0-dev_darwin_amd64.tar.gz"
      sha256 "ee9ea76a7c4d1a56333b1b775ac74f05036301ae902858acbc443368c42a1360"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.8.0-dev/pragma-ai-cli_1.8.0-dev_linux_arm64.tar.gz"
      sha256 "56182cb7e3de21455abd8f32ff4820c12eb36b8c4516fb6c279ef5edf26cff08"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.8.0-dev/pragma-ai-cli_1.8.0-dev_linux_amd64.tar.gz"
      sha256 "8001f91fc1fd4ae5ef6d27301fe1a70e354d8e4f349bde7ec62cd848ae589d81"
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
