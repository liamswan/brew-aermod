class Aermap < Formula
  desc "EPA AERMAP terrain processor (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  version "18081"
  # Source archive may be updated in-place. Skip checksum verification so builds
  # continue even if the archive changes.
  sha256 :no_check

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
    system "gfortran", "-o", "aermap", *link_flags, *object_files

    bin.install "aermap"
  end

  test do
    system "#{bin}/aermap", "-h"
  end
end
