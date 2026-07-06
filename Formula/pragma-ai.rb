class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.0-dev/pragma-ai-cli_1.1.0-dev_darwin_arm64.tar.gz"
      sha256 "95a088563064e726e748ff802b7b34dbe3f58f881a8da9b668b83d62386885c5"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.0-dev/pragma-ai-cli_1.1.0-dev_darwin_amd64.tar.gz"
      sha256 "d8dd7051ea4434247c4b649f274eaafc511039b556ee1ef6672a4dbff36cf427"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.0-dev/pragma-ai-cli_1.1.0-dev_linux_arm64.tar.gz"
      sha256 "ed153c654e166dfd3280d22ca7328b7e3671b17a6a39885c270fe209a7bea6bb"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.0-dev/pragma-ai-cli_1.1.0-dev_linux_amd64.tar.gz"
      sha256 "ad79de1b44b2990e9f57e01ec7c828d5ed27bf8314007cb6a3d7fc28afe6994e"
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
