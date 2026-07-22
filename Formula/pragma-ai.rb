class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.5-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.5-dev/pragma-ai-cli_1.3.5-dev_darwin_arm64.tar.gz"
      sha256 "4e74958218b5ecc9cb7e17af2b3cb578cfff1987c8173d9ec70464c2c0df3720"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.5-dev/pragma-ai-cli_1.3.5-dev_darwin_amd64.tar.gz"
      sha256 "7d287db577e37fff3f863e76c1871d7087a658f39490bddac7170591f9dda6c0"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.5-dev/pragma-ai-cli_1.3.5-dev_linux_arm64.tar.gz"
      sha256 "7603e48ced65118a6ca0bf2b2239efc92f0967132c6eb998f269dc0996a1ec91"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.5-dev/pragma-ai-cli_1.3.5-dev_linux_amd64.tar.gz"
      sha256 "905c4d883f90c1c737aa111366cd8d1491cf25597dec7ee1211bf257e6f412be"
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
