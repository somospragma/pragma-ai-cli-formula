class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.4.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.1-dev/pragma-ai-cli_1.4.1-dev_darwin_arm64.tar.gz"
      sha256 "4125a906548788104cb2a8eaac2a0a849f9235baec8c51154551142783f82e28"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.1-dev/pragma-ai-cli_1.4.1-dev_darwin_amd64.tar.gz"
      sha256 "af59d5a1a31238dd25605d5d1893c33ed202707f72826b316f87ee4cf0f7aaad"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.1-dev/pragma-ai-cli_1.4.1-dev_linux_arm64.tar.gz"
      sha256 "5c5c431267d126706ec9cb5629e25761b2100359334ffbe3d2956c4814b49020"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.4.1-dev/pragma-ai-cli_1.4.1-dev_linux_amd64.tar.gz"
      sha256 "27a46d52c32994e5703081da1e9d7751a6698fb26f1be60cf67f26911a6fc51a"
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
