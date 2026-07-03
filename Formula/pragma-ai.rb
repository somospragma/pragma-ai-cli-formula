class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.0"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.0/pragma-ai-cli_1.0.0_darwin_arm64.tar.gz"
      sha256 "39b96e5b4b13cda56ca509b27c0f305181620f0188bdf3ec15d9d704c069b2fb"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.0/pragma-ai-cli_1.0.0_darwin_amd64.tar.gz"
      sha256 "b86a69ffed0ecce15b01b7ec8ace98854b55f4e54d21e19de845fac6e4db495d"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.0/pragma-ai-cli_1.0.0_linux_arm64.tar.gz"
      sha256 "8276425d7a14003c663d5e5774ff4937bb9d2cd8d929072dc3810bbb3f6b6afb"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.0/pragma-ai-cli_1.0.0_linux_amd64.tar.gz"
      sha256 "c0cd4b9b428a15c764194f0b5670fdbaa664344708462966bea6cdb4972b0bad"
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
