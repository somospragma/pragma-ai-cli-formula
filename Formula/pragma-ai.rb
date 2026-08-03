class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.5.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.1-dev/pragma-ai-cli_1.5.1-dev_darwin_arm64.tar.gz"
      sha256 "edf00400bfca4b4f3173722296950fb26e02006df6f618376b28f9b8dd9c6434"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.1-dev/pragma-ai-cli_1.5.1-dev_darwin_amd64.tar.gz"
      sha256 "bbcc1025f92b89c44055b40fb751e3e6102b4905316c62a79233bda6582440c6"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.1-dev/pragma-ai-cli_1.5.1-dev_linux_arm64.tar.gz"
      sha256 "de92db79d4eec74dcf290417236d949ba134003b000582069edcad8afd21771a"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.1-dev/pragma-ai-cli_1.5.1-dev_linux_amd64.tar.gz"
      sha256 "783988443c2914a8973eaeb11fb7c4287f1177d7f03973256c589aed8d120f51"
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
