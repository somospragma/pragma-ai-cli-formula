class PragmaAi < Formula
  desc "Pragma AI CLI — sync AI assistant configuration for Pragma projects"
  homepage "https://github.com/somospragma/pragma-ai-cli-formula"
  version "1.7.3-dev"

  on_macos do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_darwin_arm64.tar.gz"
      sha256 "7a5dbd5d01a402edfce60f2e94e65330e40225dba0b882cd3816748211cacab1"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_darwin_amd64.tar.gz"
      sha256 "59568bfb1d53423a48b903dc112c2d9bfe9332c4bc39a58453923ec72ab544d8"
    end
  end

  on_linux do
    on_arm do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_linux_arm64.tar.gz"
      sha256 "750f2969322a2368bfc371294c7ca57e2423bca1e7983d527d9d25c59afece34"
    end
    on_intel do
      url "https://registry-dev.pragma.com.co/repository/pragma-raw-dev-releases/pragma-ai-cli/1.7.3-dev/pragma-ai-cli_1.7.3-dev_linux_amd64.tar.gz"
      sha256 "344f3fc3f0d62976a1b12b438f49ac1d5d1ce31d1c6d7d2c329874df18d9c1e7"
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
