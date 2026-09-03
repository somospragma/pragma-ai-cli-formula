class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.0-dev/pragma-ai-cli_1.7.0-dev_darwin_arm64.tar.gz"
      sha256 "cdd69423c650d47cd47ee13cde855158707fc1c431c8234296ac11b7a13ede2a"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.0-dev/pragma-ai-cli_1.7.0-dev_darwin_amd64.tar.gz"
      sha256 "d9eb1fbc6fff08c549832beb478fba5a641589381cc0fa4bb10edd4c7cdebb75"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.0-dev/pragma-ai-cli_1.7.0-dev_linux_arm64.tar.gz"
      sha256 "e4dd8d0ccac54612b601d2c14a84d60a4f87e818f06a8e3dc6affe635425913d"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.0-dev/pragma-ai-cli_1.7.0-dev_linux_amd64.tar.gz"
      sha256 "21ea0b0f7686016a0a6702065ea97ed1aa594edb8f6ac10d5579b1595d98701f"
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
