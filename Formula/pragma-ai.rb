class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.4-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.4-dev/pragma-ai-cli_1.1.4-dev_darwin_arm64.tar.gz"
      sha256 "4ba4bf5a7d99d4af637047e0625ceaef5354450a49f88cd3e02be7907e5b2bdc"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.4-dev/pragma-ai-cli_1.1.4-dev_darwin_amd64.tar.gz"
      sha256 "8ebeeeb1392d1b1c85eecc5a1341e7cda18611d140b7b3518733af1ef94660d6"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.4-dev/pragma-ai-cli_1.1.4-dev_linux_arm64.tar.gz"
      sha256 "3d1ebddb06a20d7ed78af86f3f224f79ceed0a40101e1b0ad89a17eed6adff07"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.4-dev/pragma-ai-cli_1.1.4-dev_linux_amd64.tar.gz"
      sha256 "2ec538479ad3b23c89c5891a536ee852f4afe0be9dc054a63ccdc304fb41d5d1"
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
