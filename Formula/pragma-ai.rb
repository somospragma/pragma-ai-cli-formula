class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.6-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_arm64.tar.gz"
      sha256 "7a61c8df973e5cc5b737c425d5af2e89756ccf45d1eec4cdf7bec84593e1fa6e"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_amd64.tar.gz"
      sha256 "482e978200b3866417964b32d38df60e181723c20c71815d22eafb9204f59c9e"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_arm64.tar.gz"
      sha256 "58a903d62355e026c4cd971f85bc376b34063147d53ede91d8ccde61cd37daaf"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_amd64.tar.gz"
      sha256 "184b95d03edb52710a3129358a4e901e2a29a8fbd20f01fdc8f2215ef66f2c08"
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
