class Aermet < Formula
  desc "EPA AERMET meteorological preprocessor (built from source)"
  homepage "https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  version "22112"
  # EPA sometimes refreshes the archive at the same URL. Disable checksum
  # validation to avoid failures when the file changes.
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
    system "gfortran", "-o", "aermet", *link_flags, *object_files

    bin.install "aermet"
  end

  test do
    # Just check if the binary exists and is executable
    assert_predicate bin/"aermet", :executable?
  end
end
