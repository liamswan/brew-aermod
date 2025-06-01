require "English"
class AermodSuite < Formula
  # AERMOD Suite with components: AERMOD 24142, AERMET 24142, AERMAP 24142
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  # This URL will be dynamically updated by the GitHub Actions workflow.
  # It points to the correct repository 'homebrew-aermod'.
  # The tag (v00000000) and filename (aermod-suite-0000.tar.gz) are placeholders.
  url "https://github.com/liamswan/homebrew-aermod/releases/download/v20250601/aermod-suite-24142.tar.gz"
  sha256 "85cea451eec057fa7e734548ca3ba6d779ed5836a3f9de14b8394575ef0d7d8e"
  license :public_domain # SHA256 for an empty tarball

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
