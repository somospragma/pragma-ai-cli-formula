class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.9.1-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.1-dev/pragma-ai-cli_1.9.1-dev_darwin_arm64.tar.gz"
      sha256 "ebfe1fb628fdd8893b981b18afd3f524641f28f2fd34ad05bc04b2c5585c9dde"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.1-dev/pragma-ai-cli_1.9.1-dev_darwin_amd64.tar.gz"
      sha256 "c560543f7d4eee4ff108a1f8b947b7a993720924962806aa1597450199c338ab"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.1-dev/pragma-ai-cli_1.9.1-dev_linux_arm64.tar.gz"
      sha256 "378d198256674c18e8ed542294b461fb97c770e77a2657def995f3f4a3d60adc"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.9.1-dev/pragma-ai-cli_1.9.1-dev_linux_amd64.tar.gz"
      sha256 "36663993b45e69d4676310932a5623a533b1e38bb0c9498ee26824017020f15c"
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
