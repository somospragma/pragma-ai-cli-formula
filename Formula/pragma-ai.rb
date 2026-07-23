class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.8"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.3.8/pragma-ai-cli_1.3.8_darwin_arm64.tar.gz"
      sha256 "f40951b137e30c096da7a9bf14f410e580007e04d0d8075ceb98c4ed1f5f8fc4"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.3.8/pragma-ai-cli_1.3.8_darwin_amd64.tar.gz"
      sha256 "a7c8ae9364dfe6fb31a26ec102ab5350a5dfd3e2fbfe83cc6277d052dffe1767"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.3.8/pragma-ai-cli_1.3.8_linux_arm64.tar.gz"
      sha256 "ccaed4a23167350c951fd177f5191285a09fef75185dc68ea1339f7b5eaff649"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.3.8/pragma-ai-cli_1.3.8_linux_amd64.tar.gz"
      sha256 "d1dd36e46b9570637928990b017861cb4138a2cb2e95895663e1ab18d1f95bb2"
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
