class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.4"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_darwin_arm64.tar.gz"
      sha256 "45023ec9b6775c35bfc1349e4796b508e3143e2c142ffb8c1eba4a06104eee86"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_darwin_amd64.tar.gz"
      sha256 "2e223607373e017d7f883f4f79551b527ef859e09901bc532f558b9e641dfb24"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_linux_arm64.tar.gz"
      sha256 "f91887fa4e3acb8939e9e00b933b5fdd50d7bf1863817c7732287dbc6932610f"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.4/pragma-ai-cli_0.1.4_linux_amd64.tar.gz"
      sha256 "aa6bc6d1d5588af52dfad80f97b040aaf12615776f96e270d5243c1d3ec30bc4"
    end
  end

  def install
    bin.install "pragma-ai"
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

      To get started, open a terminal and run:
        pragma-ai

      This will guide you through login and project setup.
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
