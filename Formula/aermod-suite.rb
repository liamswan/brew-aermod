class AermodSuite < Formula
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  url "file://#{__FILE__}"
  sha256 Digest::SHA256.hexdigest(File.read(__FILE__))
  version "2025"

  depends_on "aermod"
  depends_on "aermet"
  depends_on "aermap"

  def install
    ohai "AERMOD suite installed"
  end

  test do
    system "true"
  end
end
