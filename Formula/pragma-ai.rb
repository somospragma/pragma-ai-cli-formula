class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.5.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.0-dev/pragma-ai-cli_1.5.0-dev_darwin_arm64.tar.gz"
      sha256 "9643e14c95ef3c775a1ce3267c11b9b4f8fcc57c69557621675c92e1008420a9"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.0-dev/pragma-ai-cli_1.5.0-dev_darwin_amd64.tar.gz"
      sha256 "7208e0cacba705f3809be6ac89bf96b68effc0efbc0c662975ee3265c03f6d66"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.0-dev/pragma-ai-cli_1.5.0-dev_linux_arm64.tar.gz"
      sha256 "5ffb17d3bf187847d771f60dba72ef7395bb016a76412219590130f1ad48c75e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.5.0-dev/pragma-ai-cli_1.5.0-dev_linux_amd64.tar.gz"
      sha256 "762f4c86f92542e3c0235c724dfb7b1efb3a55267b39667f6714d987155a4fc8"
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
