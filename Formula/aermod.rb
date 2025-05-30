class Aermod < Formula
  desc "EPA AERMOD air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  version "24142"
  
  # Use the official EPA URL but with a stable version
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  
  # Alternative approach: use a versioned local file
  # This helps when EPA updates the file at the same URL
  #resource "aermod_source" do
  #  url "file://#{HOMEBREW_PREFIX}/Homebrew/Library/Taps/liamswan/homebrew-brew-aermod/downloads/aermod_24142.zip"
  #  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  #end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking for faster production builds"

  def install
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"
    compile_flags = ["-O2"]
    compile_flags += %w[-fbounds-check -Wuninitialized] unless build.without? "bounds-check"
    link_flags = %w[-O2]

    source_files = Dir["*.f", "*.f90"].sort
    ENV.deparallelize
    source_files.each do |src|
      system "gfortran", "-c", *compile_flags, src
    end

    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system "gfortran", "-o", "aermod", *link_flags, *object_files

    bin.install "aermod"
  end

  test do
    # Just check if the binary exists and is executable
    assert_predicate bin/"aermod", :executable?
  end
end
