class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.4"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.1.4/pragma-ai-cli_1.1.4_darwin_arm64.tar.gz"
      sha256 "94b4cc8ddc66c96ce82fc1265bb95c198c48bf05c17f139e1c406931ab5eecb7"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.1.4/pragma-ai-cli_1.1.4_darwin_amd64.tar.gz"
      sha256 "ddd30f95841ba4a7b184283d5117c62f5132c92e749baeb9d0c915d755fcb6e1"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.1.4/pragma-ai-cli_1.1.4_linux_arm64.tar.gz"
      sha256 "799f8cb8faf6ae305d7d744f877ae13768880ff81eccde066484b96ba987b9a0"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.1.4/pragma-ai-cli_1.1.4_linux_amd64.tar.gz"
      sha256 "acc4f2a587861b52ecc278b4eef8fc6e210ffbeab94160b26bc41566c2beaf51"
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
