class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.9.0-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.0-dev/pragma-ai-cli_1.9.0-dev_darwin_arm64.tar.gz"
      sha256 "9ce60096f7b78a781d5473d5afdd821ccf162db30d5ec892f91c7269361eb039"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.0-dev/pragma-ai-cli_1.9.0-dev_darwin_amd64.tar.gz"
      sha256 "06b9ab33e27d3314d6e80fcccc52bda8d49cce5b856a3c4e9026a53b3befd052"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.0-dev/pragma-ai-cli_1.9.0-dev_linux_arm64.tar.gz"
      sha256 "7534507631681b59f0f86d31c083d00cf19d8f378cf11f07b68b1fe8278a51a5"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.0-dev/pragma-ai-cli_1.9.0-dev_linux_amd64.tar.gz"
      sha256 "cfb3daf7149d7143b2a3b9b7a05a2b58abd5bd0b9ecda0e93c342699d9c0247b"
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
