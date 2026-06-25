class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_darwin_arm64.tar.gz"
      sha256 "acfae6d2376a19eeb9d8bc5237347cc36195e4a1fe1e0d871b2d50f451ccbc52"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_darwin_amd64.tar.gz"
      sha256 "0d2b826bb35bab7e3ee8b6d702c106704e1a8deaf4ee5f8a77f0ca66cc0dbb63"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_linux_arm64.tar.gz"
      sha256 "9d0422e006ab942c2057d48bfb003c29c2777d6d8c4397fe346debd273408b06"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.1/pragma-ai-cli_0.1.1_linux_amd64.tar.gz"
      sha256 "c5f114138077b01f3d95cb2c7824a6cb175ba3947bd61290bce58553876f8906"
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

      Background services have been configured to sync your assets every 4 hours.

      To get started, open a terminal and run:
        pragma-ai

      This will guide you through login and project setup.
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
