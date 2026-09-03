class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.1-dev/pragma-ai-cli_1.7.1-dev_darwin_arm64.tar.gz"
      sha256 "59a39663663ac41be47e34625b15546515a95ddb57d0b075d241d9d5549a015c"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.1-dev/pragma-ai-cli_1.7.1-dev_darwin_amd64.tar.gz"
      sha256 "c2bd38d777e21d225bdd697c9f3ef8392eb000ab7a0a93bec791ab29601bc4ba"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.1-dev/pragma-ai-cli_1.7.1-dev_linux_arm64.tar.gz"
      sha256 "815e03d90dea19c7cb18baa7710a78e9ec2b21c29dc68b9b5b3ef889cffd538e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.1-dev/pragma-ai-cli_1.7.1-dev_linux_amd64.tar.gz"
      sha256 "3196a6fd9e9ecd5aac6489a057fa1e653b6d69bc5d17b8019f7543b0b5df8482"
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
