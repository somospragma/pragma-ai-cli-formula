class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.10-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.10-dev/pragma-ai-cli_1.7.10-dev_darwin_arm64.tar.gz"
      sha256 "2e44fb2a33757c4dada8c06127f39cdbbd73667b4438c39ae1d1b3ad82a8b4f2"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.10-dev/pragma-ai-cli_1.7.10-dev_darwin_amd64.tar.gz"
      sha256 "ccf1ae071b1e7a3c0bb8c745d470c5f68a2f124f1c3fa9adaa0f87d9d9419c2a"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.10-dev/pragma-ai-cli_1.7.10-dev_linux_arm64.tar.gz"
      sha256 "f9d5f72f2809fb64ad8399643607f57f711e49f8db8e55099ff7007a6a16b6ab"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.10-dev/pragma-ai-cli_1.7.10-dev_linux_amd64.tar.gz"
      sha256 "d8e72e2716323907797757e77a81d2871e28368e9427794796354fb6d87d4b27"
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
