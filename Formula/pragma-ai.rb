class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.2-dev/pragma-ai-cli_1.7.2-dev_darwin_arm64.tar.gz"
      sha256 "a3d935b45cd4fed4b8284c8c547f4bc3ffb17e91ea6776af9be0e2c1f259a758"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.2-dev/pragma-ai-cli_1.7.2-dev_darwin_amd64.tar.gz"
      sha256 "befcfc2015421e22aa3918dfde98823449764c67222061f475cd5872462ad44e"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.2-dev/pragma-ai-cli_1.7.2-dev_linux_arm64.tar.gz"
      sha256 "c034d839391e3070f606de21cb7f1f50586916458a090379debe40781602c296"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.2-dev/pragma-ai-cli_1.7.2-dev_linux_amd64.tar.gz"
      sha256 "e71483b416c77b7aa14d954fde5150394b4e82124e1a4fa75536cb9972fad448"
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
