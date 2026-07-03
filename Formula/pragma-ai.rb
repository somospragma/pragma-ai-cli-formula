class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.1"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.1/pragma-ai-cli_1.0.1_darwin_arm64.tar.gz"
      sha256 "c6925c52357890290d9b994c96ddd115253c6434e18f5f8e2212536895f618aa"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.1/pragma-ai-cli_1.0.1_darwin_amd64.tar.gz"
      sha256 "e39f8d08c787f63bb44f3220a2688fc532738b577f5a9d7dc128c36e21046d2e"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.1/pragma-ai-cli_1.0.1_linux_arm64.tar.gz"
      sha256 "3dd25dba0b5af5bcc8ef17b3825f717aba6e083445ee09ad83052e6278bbd793"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.1/pragma-ai-cli_1.0.1_linux_amd64.tar.gz"
      sha256 "3ea5c9024fca4b455625f7d1ff9beed1b81a1f53d80ccc3d7fb09b6debabcded"
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
