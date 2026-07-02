class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "0.1.6-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_arm64.tar.gz"
      sha256 "f070121c165a09b3f618e0374b8148574f686ee62e8a0060943075f74a408203"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_darwin_amd64.tar.gz"
      sha256 "f934d66a3425c5c06ee87280a330041ff835f512817c09b452a7e789b6061bb5"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_arm64.tar.gz"
      sha256 "ddef14c33dd9d3e162f159054d1c65ac09f4c3d332bbb6433ec47411a7a1c6b0"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/0.1.6-dev/pragma-ai-cli_0.1.6-dev_linux_amd64.tar.gz"
      sha256 "c1cba7964fd8a130afd7af4753e7e054e6b8811db29acad7495198254a4c7b97"
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
