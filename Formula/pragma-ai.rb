class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.5"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_darwin_arm64.tar.gz"
      sha256 "4bc32c5cae7ca359d552a8358ffdf55d3da5caee1e4db9f5b04d0f888e682569"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_darwin_amd64.tar.gz"
      sha256 "0653de2f12bac85cb3e32bbbaf9b6f48994f942f9fa401b35b1b97198f9b77ad"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_linux_arm64.tar.gz"
      sha256 "038b3cba1fea0490fd041dd986682b355640859769597f313826ebd6df46446a"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/0.1.5/pragma-ai-cli_0.1.5_linux_amd64.tar.gz"
      sha256 "86f310e9fcf2f2bbec5d336e7e5d397279b0a7a3e20912969470b1ba3aae9d85"
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
