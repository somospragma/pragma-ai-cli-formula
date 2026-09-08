class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_darwin_arm64.tar.gz"
      sha256 "e688a10a68dc30b31dfa540b66040e5506ea4002388c62a5278b6286dd8942e6"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_darwin_amd64.tar.gz"
      sha256 "76e1f835c0858cb7834cdec695ffeb15083b848ac470d369d4d76772f50f1576"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_linux_arm64.tar.gz"
      sha256 "ddb027483ccb6987768fa7da0bd07432b08169ba84ca3a991e2d5a98b4e1f2f5"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_linux_amd64.tar.gz"
      sha256 "a0a6f36a0685c220e463d52c86ad375d822d93281106b6fd550fdbd11f03fab7"
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
