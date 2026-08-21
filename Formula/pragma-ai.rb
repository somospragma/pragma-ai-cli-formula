class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.3"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.3/pragma-ai-cli_1.6.3_darwin_arm64.tar.gz"
      sha256 "58d53a1c8b499c8df6f7287e9afafbcd27619d6990fa471b183384b9ab8aec6b"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.3/pragma-ai-cli_1.6.3_darwin_amd64.tar.gz"
      sha256 "e551bcceb6a0c3c291aa848171aaf6a7b4680e832142745a8fc094866dcd89af"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.3/pragma-ai-cli_1.6.3_linux_arm64.tar.gz"
      sha256 "b43a31a5084f0b1042c168c951120a78a28f946212a841a3f641b9c346817ccf"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.3/pragma-ai-cli_1.6.3_linux_amd64.tar.gz"
      sha256 "9c62b0e221853cc54a8a728e46c49c3b3ee5204e58ee1b48daa02b2283750fa7"
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
