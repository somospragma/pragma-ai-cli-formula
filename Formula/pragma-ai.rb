class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.0.2-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.2-dev/pragma-ai-cli_1.0.2-dev_darwin_arm64.tar.gz"
      sha256 "1bf0da297d03f8cf1fd883e9e5d0cc4c281fd70ac1660344bc034b3ae4f4ccdd"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.2-dev/pragma-ai-cli_1.0.2-dev_darwin_amd64.tar.gz"
      sha256 "21d808ca06b171b95992cfea066258d199e42cbb1e0c16b9597dbbcedabdd543"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.2-dev/pragma-ai-cli_1.0.2-dev_linux_arm64.tar.gz"
      sha256 "1307a550518075da4b25cfeba25458fb15aa89ddbd3831d78c0972b2cd6e4e80"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.0.2-dev/pragma-ai-cli_1.0.2-dev_linux_amd64.tar.gz"
      sha256 "dd691e3ff14bfa3da803dc65e29043e842a0c0ed1afb56ac2ed78e9d27336cd9"
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
