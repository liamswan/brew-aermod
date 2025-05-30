class Aermod < Formula
  desc "EPA AERMOD air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  version "23132"
  sha256 "0f0e0d0c0b0a09080706050403020100f0e0d0c0b0a09080706050403020100f" # example only

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
    system "#{bin}/aermod", "-h"
  end
end
