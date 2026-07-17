class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.2.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.0-dev/pragma-ai-cli_1.2.0-dev_darwin_arm64.tar.gz"
      sha256 "abeb0c8456818c997465a4a116b761fd07cea8b5f1d8710ecd7061d65d14e9fc"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.0-dev/pragma-ai-cli_1.2.0-dev_darwin_amd64.tar.gz"
      sha256 "18a82d8e246bdb9775716ebe4e0473724b8e7efd3ea4700592ba239588a8c79a"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.0-dev/pragma-ai-cli_1.2.0-dev_linux_arm64.tar.gz"
      sha256 "34d251e68cea2cebdecafade2870d6d25325cff4e0e3e25ed304e30fffee8ccf"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.0-dev/pragma-ai-cli_1.2.0-dev_linux_amd64.tar.gz"
      sha256 "da8557a8c35f7fc0a07aace853eeeed222fca14156c15710443fd23a906201b8"
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
