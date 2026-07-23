class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.3.8-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.8-dev/pragma-ai-cli_1.3.8-dev_darwin_arm64.tar.gz"
      sha256 "d5a501315287031edaf75d9414480c800042a45534cb441668370e581513bdce"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.8-dev/pragma-ai-cli_1.3.8-dev_darwin_amd64.tar.gz"
      sha256 "8a554b14b71d427a2e76d35f6f1215db6ee7cf498ac4e0ec2ba8ae0082a2c86a"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.8-dev/pragma-ai-cli_1.3.8-dev_linux_arm64.tar.gz"
      sha256 "b5d304e29be4262452421f6a68fdb34c1729bb13c6717f6324182d19cddafce8"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.3.8-dev/pragma-ai-cli_1.3.8-dev_linux_amd64.tar.gz"
      sha256 "60245f5299af574a7771128f19d43d77501eae731b8c1c694a86117ed6ebc3ff"
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
