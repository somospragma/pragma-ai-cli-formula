class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.0-dev/pragma-ai-cli_1.3.0-dev_darwin_arm64.tar.gz"
      sha256 "1da54bd2b462f2b53c9066483482787acefc63a4bb716a32ad487dcb8b19ede3"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.0-dev/pragma-ai-cli_1.3.0-dev_darwin_amd64.tar.gz"
      sha256 "9b24fd992529410c120a54bcf0b1b733ad2776c0ba74129496915f954fa70909"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.0-dev/pragma-ai-cli_1.3.0-dev_linux_arm64.tar.gz"
      sha256 "7023b3a6f1b01e7c3a9d965c9350dc27c49ff337098c13755a8ebce83647567e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.0-dev/pragma-ai-cli_1.3.0-dev_linux_amd64.tar.gz"
      sha256 "f7b486f64187accda4aec6088bac8eaf03fb6100a1ccc807dff19f6a4c2d724c"
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
