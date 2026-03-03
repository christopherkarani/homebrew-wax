class Wax < Formula
  desc "CLI for the Wax MCP server"
  homepage "https://github.com/christopherkarani/Wax"
  url "https://github.com/christopherkarani/Wax/archive/refs/tags/waxmcp-v0.1.13.tar.gz"
  sha256 "a055f14293a3314395d2d634dabf571e9e9a6127bda8899303ce8893fdb95c0f"
  license "MIT"

  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "wax-cli"
    bin.install ".build/release/wax-cli" => "wax"
  end

  test do
    # Check that the binary runs and outputs help
    output = shell_output("#{bin}/wax --help")
    assert_match "Usage:", output
  end
end
