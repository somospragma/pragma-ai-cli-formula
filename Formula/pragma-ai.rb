class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.2"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.2/pragma-ai-cli_1.0.2_darwin_arm64.tar.gz"
      sha256 "4608fd3948d0838efe9dcd495323730b848a7e9dc7b881913a19a4a729269d2c"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.2/pragma-ai-cli_1.0.2_darwin_amd64.tar.gz"
      sha256 "105aa9177539a8bcc89fa90a954eea866ad045b2b12e658638b5a5b33bb06bb8"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.2/pragma-ai-cli_1.0.2_linux_arm64.tar.gz"
      sha256 "5581668ba93cbf0c37bf8cd4f121f902c87b77af4d41394417fa9a4ba4abfacf"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.0.2/pragma-ai-cli_1.0.2_linux_amd64.tar.gz"
      sha256 "e3a6297e3686a03b5fd3dd9fcec0b3082bbddfa2c20522e27f63b0c3dcc3b90e"
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
