class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.3-dev/pragma-ai-cli_1.6.3-dev_darwin_arm64.tar.gz"
      sha256 "78d0d4212ff6af8d8e46eb1ca7bb67a4b6acbf879a6ef9c44fae4ca33b4ba5ba"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.3-dev/pragma-ai-cli_1.6.3-dev_darwin_amd64.tar.gz"
      sha256 "ca75841d00b021829d61e8fb6ee0093df5758eb8d6f07160c17e8e9c7c4d517c"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.3-dev/pragma-ai-cli_1.6.3-dev_linux_arm64.tar.gz"
      sha256 "181400204cd6700723bf58f4663d949ae70ae4a3ac2de2269d41900d7bddb119"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.6.3-dev/pragma-ai-cli_1.6.3-dev_linux_amd64.tar.gz"
      sha256 "667fa4ad067480d03be1124f67b6c2c25dad2f13cd4a8251e7750b8501d5b907"
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
