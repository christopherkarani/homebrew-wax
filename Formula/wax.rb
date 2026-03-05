class Wax < Formula
  desc "CLI for the Wax MCP server"
  homepage "https://github.com/christopherkarani/Wax"
  url "https://github.com/christopherkarani/Wax/archive/refs/tags/waxmcp-v0.1.13.tar.gz"
  sha256 "a055f14293a3314395d2d634dabf571e9e9a6127bda8899303ce8893fdb95c0f"
  license "MIT"
  revision 1

  depends_on xcode: ["15.0", :build]

  def install
    # The upstream repo defines a `waxTests` target with a custom path of
    # `Tests/WaxTests`, but empty directories aren't included in GitHub source
    # archives. Ensure the directory exists so SwiftPM's package graph
    # validation succeeds.
    mkdir_p "Tests/WaxTests"

    # CoreML on-device ANE compilation can hang in CLI contexts; default to CPU-only for reliability.
    inreplace "Sources/WaxVectorSearchMiniLM/MiniLMEmbedder.swift",
      "computeUnitsOrder: [MLComputeUnits] = [.cpuAndNeuralEngine, .all, .cpuOnly]",
      "computeUnitsOrder: [MLComputeUnits] = [.cpuOnly]"

    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "wax-cli"
    libexec.install ".build/release/wax-cli" => "wax"
    libexec.install Dir[".build/release/*.bundle"]
    rm_f bin/"wax"
    bin.write_exec_script libexec/"wax"
  end

  test do
    output = shell_output("#{bin}/wax --help")
    assert_match "USAGE:", output

    health = shell_output("#{bin}/wax vector-health --format text --store-path #{testpath}/health.wax")
    assert_match "Vector health: PASS", health
  end
end
