class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.5.0"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.5.0/pragma-ai-cli_1.5.0_darwin_arm64.tar.gz"
      sha256 "f154df39c11e6a58aa86281218ac40dc766b377010fff5a1f41a49f20bbb8347"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.5.0/pragma-ai-cli_1.5.0_darwin_amd64.tar.gz"
      sha256 "eebb8c930d9b8f87b450eac27bf2b023e0139f4214bfc3c0ad62c71459a537ce"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.5.0/pragma-ai-cli_1.5.0_linux_arm64.tar.gz"
      sha256 "15c5adafed9f6db1b8599edece97cfbc641db61c62072e0347f03c9480fb0614"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.5.0/pragma-ai-cli_1.5.0_linux_amd64.tar.gz"
      sha256 "5aa42e64fbe47a2a7bc3a4b46b9b8e56f304be9f04c9d6ae6c404f8c35d20c43"
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
