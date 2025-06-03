require "English"
class AermodSuite < Formula
  # AERMOD Suite with components: AERMOD 24142, AERMET 24142, AERMAP 24142
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  url "https://github.com/liamswan/homebrew-aermod/raw/main/README.md"
  version "24142"
  sha256 "608ab0e3f137dd1a5cfe13b0fbbc46815d75775950d43b11bafd0021e9455f22"
  license :public_domain

  depends_on "liamswan/aermod/aermap"
  depends_on "liamswan/aermod/aermet"
  depends_on "liamswan/aermod/aermod"

  def install
    # Create a placeholder file to mark installation
    (prefix/"aermod-suite-#{version}.txt").write "AERMOD Suite #{version} - Meta-formula including AERMOD, AERMET, and AERMAP\n"
    # Install README.md if it exists
    prefix.install "README.md" if File.exist?("README.md")
  end
  
  def caveats
    <<~EOS
      This package installs AERMOD, AERMET, and AERMAP executables.
      
      AERMAP has been installed with NAD83 grid shift files for DEM data conversion.
      These files are located in:
        #{HOMEBREW_PREFIX}/share/aermap/grid_shift_files/
      
      For more information, see:
        #{HOMEBREW_PREFIX}/share/doc/aermap/aermap_readme.txt
    EOS
  end

  test do
    assert_match "AERMOD", shell_output("#{Formula["aermod"].bin}/aermod -h 2>&1", 1)
    assert_match "AERMET", shell_output("#{Formula["aermet"].bin}/aermet -h 2>&1", 1)
    assert_match "AERMAP", shell_output("#{Formula["aermap"].bin}/aermap -h 2>&1", 1)
  end
end
