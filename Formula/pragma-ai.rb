class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.2.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.3-dev/pragma-ai-cli_1.2.3-dev_darwin_arm64.tar.gz"
      sha256 "42cec3428c81b1f2e785bda3f62547c13d5c099e1b65e055a5162f4f78b694cf"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.3-dev/pragma-ai-cli_1.2.3-dev_darwin_amd64.tar.gz"
      sha256 "c95bd828eb080f146b14c01493f2c2f6f5f8af1bf0861ea2db54a9d97d476e2c"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.3-dev/pragma-ai-cli_1.2.3-dev_linux_arm64.tar.gz"
      sha256 "1b7a32a5b621c88fdbf8c143406ce991f7d9816947e057313d331dbafe0aa88d"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.2.3-dev/pragma-ai-cli_1.2.3-dev_linux_amd64.tar.gz"
      sha256 "7bf0f2e8ea2f009086bcab37ddb3da33add416fbf1887754cf7ad4c69b8b4f12"
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
