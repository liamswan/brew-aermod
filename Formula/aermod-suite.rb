class AermodSuite < Formula
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  version "2025"
  url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "aermod"
  depends_on "aermet"
  depends_on "aermap"

  def install
    pkgshare.install "README.md" if File.exist? "README.md"
  end

  test do
    system "#{Formula["aermod"].bin}/aermod", "-h" rescue nil
    system "#{Formula["aermet"].bin}/aermet", "-h" rescue nil
    system "#{Formula["aermap"].bin}/aermap", "-h" rescue nil
  end
end
