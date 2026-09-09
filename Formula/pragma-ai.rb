class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.4-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.4-dev/pragma-ai-cli_1.7.4-dev_darwin_arm64.tar.gz"
      sha256 "7fda231cd3b2e675ffd56b8f8c91d2238e0560ddf9af2635b86cf4cf08e7a6e9"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.4-dev/pragma-ai-cli_1.7.4-dev_darwin_amd64.tar.gz"
      sha256 "556fcd633ec772a77b704980b94d31136555f928fbf6a79685b602cc28bd55cb"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.4-dev/pragma-ai-cli_1.7.4-dev_linux_arm64.tar.gz"
      sha256 "896cabfcc38b00314d6dc7fb05b1b95b000b34b717b81fc193f3b261e71da2b4"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.4-dev/pragma-ai-cli_1.7.4-dev_linux_amd64.tar.gz"
      sha256 "13c8d4635116165b859393ac2b890a4cbcf4a142137b336182f03a183d5a7fba"
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
