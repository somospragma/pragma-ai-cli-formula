class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.2"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_darwin_arm64.tar.gz"
      sha256 "047975ec6d6c76fe0e4eb8964b65eba34b1c858ab2321f32f78086d515f88e1c"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_darwin_amd64.tar.gz"
      sha256 "0ecf540dee3670c5b3223ea1e5a3dc42f0eabe9bbd37c6fdd62c33735a7d0c13"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_linux_arm64.tar.gz"
      sha256 "50af870d78724c5d234159faca21bf452f1796e0a70770de5bc7fa88bd140947"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.2/pragma-ai-cli_0.1.2_linux_amd64.tar.gz"
      sha256 "0be85dae479a6b2de576c35bf828cab61aaca48c0771547e27f29fb9efcb0925"
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
