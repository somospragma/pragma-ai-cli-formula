class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.2-dev/pragma-ai-cli_1.1.2-dev_darwin_arm64.tar.gz"
      sha256 "80e94e5fe6a5c7fd6cfb8ac861e0d91e9fc1542465a2b39a8f0070921fe6bc90"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.2-dev/pragma-ai-cli_1.1.2-dev_darwin_amd64.tar.gz"
      sha256 "374f7959b1d8b0d02cbba5b4b92439888d723a99628ac66f872c730c0a598dd5"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.2-dev/pragma-ai-cli_1.1.2-dev_linux_arm64.tar.gz"
      sha256 "73e41956459925be6d8da259bb8f3fafee9c3ce2901247b770cc64a39c812769"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.2-dev/pragma-ai-cli_1.1.2-dev_linux_amd64.tar.gz"
      sha256 "46f11ac59fb1bec73c0ffca92691fdbe56f71113cf984d3e23d2d6135e1be550"
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
