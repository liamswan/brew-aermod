class Aermet < Formula
  desc "EPA AERMET meteorological preprocessor (built from source)"
  homepage "https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  version "22112"
  sha256 "1111111111111111111111111111111111111111111111111111111111111111" # example only

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking"

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
    system "gfortran", "-o", "aermet", *link_flags, *object_files

    bin.install "aermet"
  end

  test do
    system "#{bin}/aermet", "-h"
  end
end
