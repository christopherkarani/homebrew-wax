class Wax < Formula
  desc "CLI for the Wax MCP server"
  homepage "https://github.com/christopherkarani/Wax"
  version "0.1.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/christopherkarani/Wax/releases/download/waxmcp-v0.1.11/WaxCLI-darwin-arm64"
      sha256 "76b10dd86362de6c526a8c2d778a4aab23b30df5952d7fbacf0ec2da7265dba2"
    end
    on_intel do
      url "https://github.com/christopherkarani/Wax/releases/download/waxmcp-v0.1.11/WaxCLI-darwin-x64"
      sha256 "4509dda05874a4074effacb26df491f5bbade5d071d38b7621474ef0be6c61a1"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "WaxCLI-darwin-arm64" => "wax"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "WaxCLI-darwin-x64" => "wax"
    end
  end

  test do
    system "#{bin}/wax", "--help"
  end
end
