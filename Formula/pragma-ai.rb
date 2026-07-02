class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.8-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.8-dev/pragma-ai-cli_0.1.8-dev_darwin_arm64.tar.gz"
      sha256 "394174aa0abafe785a404772abeb957327c2575ab8ae0f191e70d05424243355"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.8-dev/pragma-ai-cli_0.1.8-dev_darwin_amd64.tar.gz"
      sha256 "b6839c57bd97ec22a05bd8982329284edd24a2f9ff9232fb5469c0642a3cb0cf"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.8-dev/pragma-ai-cli_0.1.8-dev_linux_arm64.tar.gz"
      sha256 "0d00262c98293595598bb3f73972de77552d77f1d6450d4d1847591e1da90711"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.8-dev/pragma-ai-cli_0.1.8-dev_linux_amd64.tar.gz"
      sha256 "df43b13cf9ce23404b3b67c6497c41ae2a49c945b123e33f705706c515154d12"
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
