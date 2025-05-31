class AermodSuite < Formula
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz"
  license :public_domain
  version "2025"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "aermap"
  depends_on "aermet"
  depends_on "aermod"

  def install
    pkgshare.install "README.md" if File.exist? "README.md"
  end

  test do
    assert_match "AERMOD", shell_output("#{Formula["aermod"].bin}/aermod -h 2>&1", 1)
    assert_match "AERMET", shell_output("#{Formula["aermet"].bin}/aermet -h 2>&1", 1)
    assert_match "AERMAP", shell_output("#{Formula["aermap"].bin}/aermap -h 2>&1", 1)
  end
end
