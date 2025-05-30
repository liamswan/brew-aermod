class Aermet < Formula
  desc "EPA AERMET meteorological preprocessor (built from source)"
  homepage "https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet"
  version "24142"
  
  # Main URL for the latest version
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  sha256 "0e13af282c990dd08ec535d9476b850b559fe190a48942f2d0e2be705b43fab2"
  
  # Versioned resources for specific versions
  resource "aermet_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermet_24142.zip"
    sha256 "0e13af282c990dd08ec535d9476b850b559fe190a48942f2d0e2be705b43fab2"
  end
  
  # Add older versions as needed
  # resource "aermet_22112" do
  #   url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermet_22112.zip"
  #   sha256 "add_checksum_here"
  # end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking"
  option "with-version", "Specify a version to install (e.g., --with-version=24142)"

  def install
    # Allow installation of a specific version if requested
    if build.with? "version"
      version_arg = build.value("version")
      version_resource = "aermet_#{version_arg}"
      if build.without? "version" || !resource_exists?(version_resource)
        odie "Version #{version_arg} is not available. Please choose a valid version or omit the --with-version option."
      end
      resource(version_resource).stage { buildpath.install Dir["*"] }
    end

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
    
    # Try running with -h flag (some versions may not support this)
    system bin/"aermet", "-h" rescue nil
  end
  
  # Helper method to check if a resource exists
  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
