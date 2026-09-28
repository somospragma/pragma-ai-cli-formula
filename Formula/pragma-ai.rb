class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.8.0"

  on_macos do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.8.0/pragma-ai-cli_1.8.0_darwin_arm64.tar.gz"
      sha256 "4ef3b4e0f34f8d9c54b4769e767c68dd42b5ecca6441e6abe4fd42ecf5fa377f"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.8.0/pragma-ai-cli_1.8.0_darwin_amd64.tar.gz"
      sha256 "30fc6881cdfa65c514cd8a9defd55277a991c112bf976033f1bfd1fc2334d192"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.8.0/pragma-ai-cli_1.8.0_linux_arm64.tar.gz"
      sha256 "a93fa4f7d0a4ff0b203dd60ec8afd1f981a3909b8842963ccaf043b4c4316be4"
    end
    on_intel do
      url "https://registry.pragma.com.co/repository/pragma-raw-releases/pragma-ai-cli/1.8.0/pragma-ai-cli_1.8.0_linux_amd64.tar.gz"
      sha256 "6e99b7b69535ac4cb927b6423fc82ef1f937f28f61efe93fcc7215a75ce2f0bd"
    end
  end

  def install
    bin.install "pragma-ai"
    bin.install "pragma-ai-gui"
    bin.install "pragma-ai-telemetry"
  end

  def post_install
    # Install background services (launchd agent for periodic sync)
    system "#{bin}/pragma-ai", "agent", "install"
    # Run one sync cycle immediately so every known project's IDE hooks and
    # assets pick up this version right away, instead of waiting for the
    # next scheduled run or IDE session.
    system "#{bin}/pragma-ai", "agent", "run"
  end

  def caveats
    <<~EOS
      Pragma AI has been installed successfully.

      Background services have been configured to sync your assets every 24 hours.

      Available commands:
        pragma-ai       — CLI (terminal)
        pragma-ai-gui   — GUI (interfaz gráfica)

      To get started, open a terminal and run:
        pragma-ai

      Or launch the graphical interface:
        pragma-ai-gui
    EOS
  end

  test do
    system "\#{bin}/pragma-ai", "version"
  end
end
