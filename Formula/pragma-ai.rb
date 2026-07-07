class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.1.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.3-dev/pragma-ai-cli_1.1.3-dev_darwin_arm64.tar.gz"
      sha256 "5bba12a439d0d2cc6acd1e7d77ce72f250cab2eb57dc8e8473e2455c6da0e3a7"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.3-dev/pragma-ai-cli_1.1.3-dev_darwin_amd64.tar.gz"
      sha256 "b60d48cf37fc74626d9faf8c0e6936421ad5f4f5c9f13ae6fe5e2a97b75ba8d2"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.3-dev/pragma-ai-cli_1.1.3-dev_linux_arm64.tar.gz"
      sha256 "d21d0188d5155e6b55ea1100f0397c6e526022324bebacba56857bdb8da29028"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.1.3-dev/pragma-ai-cli_1.1.3-dev_linux_amd64.tar.gz"
      sha256 "58601544a09d38a9950cbbef15ea43cf509f83581f701494a23b3bd5f12eaf7c"
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
