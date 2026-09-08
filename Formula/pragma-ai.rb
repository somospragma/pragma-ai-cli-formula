class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.6.5"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.5/pragma-ai-cli_1.6.5_darwin_arm64.tar.gz"
      sha256 "d3a4c034ae326431921c772474e7f21a4d1cd4e984e5acdd973623b39fdb6296"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.5/pragma-ai-cli_1.6.5_darwin_amd64.tar.gz"
      sha256 "efe1d374dccb9fd19e9223ef53b51508fc0ce16e8c8a97732cc989648cc72d51"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.5/pragma-ai-cli_1.6.5_linux_arm64.tar.gz"
      sha256 "10d6be51c8f625be4e4fa7a1dea803e55b75021613e56715c17b8b6170a35f78"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.6.5/pragma-ai-cli_1.6.5_linux_amd64.tar.gz"
      sha256 "01bb946070e3be830dccc52b02c4feb47a3049e53d19b8c23922b11cccb03e76"
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
