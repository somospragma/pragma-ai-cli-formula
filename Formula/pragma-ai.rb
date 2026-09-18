class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.4"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.4/pragma-ai-cli_1.7.4_darwin_arm64.tar.gz"
      sha256 "23fb129d6733ae7019182ef4b44987e3250d21435cad67ae97772602c5aee14d"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.4/pragma-ai-cli_1.7.4_darwin_amd64.tar.gz"
      sha256 "2780f8189270dc545282e0b696bd3003eb85a75a0d6c8ea341debe8f5220ac44"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.4/pragma-ai-cli_1.7.4_linux_arm64.tar.gz"
      sha256 "d0b343fc0f06149bb21fb7b8ab2178667b3ff132f392fc947dd67feddcf9e52d"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.7.4/pragma-ai-cli_1.7.4_linux_amd64.tar.gz"
      sha256 "f3eec47a01bf340b4f151a8e7abf15f6bc15c5ab0bf8aa7c306f2fd028944ed6"
    end
  end

  def install
    bin.install "pragma-ai"
    bin.install "pragma-ai-gui" if File.exist?("pragma-ai-gui")
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
