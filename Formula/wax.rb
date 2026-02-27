class Wax < Formula
  desc "CLI for the Wax MCP server"
  homepage "https://github.com/christopherkarani/Wax"
  url "https://github.com/christopherkarani/Wax/archive/refs/tags/waxmcp-v0.1.11.tar.gz"
  sha256 "cb543353e3ff84d5043e100ae02794ff33e3d6cadf3569b0ddf8269e8beac867"
  license "MIT"

  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "WaxCLI"
    bin.install ".build/release/WaxCLI" => "wax"
  end

  test do
    # Check that the binary runs and outputs help
    output = shell_output("#{bin}/wax --help")
    assert_match "Usage:", output
  end
end
