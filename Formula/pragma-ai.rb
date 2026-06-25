class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.2"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_darwin_arm64.tar.gz"
      sha256 "ca45e342013e4ee134d6c42ce4f165211db3f91645f6c277e7a336fb13215927"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_darwin_amd64.tar.gz"
      sha256 "844971519bd564db1296ae608e4ece82112719979d7cb7cd7a245542901c5f2b"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_linux_arm64.tar.gz"
      sha256 "76facbdbce834722cbed258786306ac12a0f4b118fa60bf19008f985b7e07181"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_linux_amd64.tar.gz"
      sha256 "210ac068382c9a2b2393abedfb4a036d6b2747216fb9ff66eef6c15e400b5b81"
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
