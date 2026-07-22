class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.6-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.6-dev/pragma-ai-cli_1.3.6-dev_darwin_arm64.tar.gz"
      sha256 "806519b148b79a8c0bd6729b878056a850ad4a39df1bd9391f615731c97c779e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.6-dev/pragma-ai-cli_1.3.6-dev_darwin_amd64.tar.gz"
      sha256 "8713042d5284c21a3f2b6567d362b68431c3fe2ef9ee55c29016e962276a1f5e"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.6-dev/pragma-ai-cli_1.3.6-dev_linux_arm64.tar.gz"
      sha256 "08ab1016d0490934c200acb86c97139f7eab403da4026f2abe64164aa3a1685c"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.6-dev/pragma-ai-cli_1.3.6-dev_linux_amd64.tar.gz"
      sha256 "f5e156eb1724bd7a04594b953d27f7065c17645fa0e78bfb96f4812fa074f582"
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
