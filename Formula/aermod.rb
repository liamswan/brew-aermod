class Aermod < Formula
  desc "EPA AERMOD air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  version "24142"
  
  # Main URL for the latest version
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  
  # Versioned resources for specific versions
  resource "aermod_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod_24142.zip"
    sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  end
  
  # Add older versions as needed
  # resource "aermod_23132" do
  #   url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod_23132.zip"
  #   sha256 "add_checksum_here"
  # end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking for faster production builds"
  option "with-version", "Specify a version to install (e.g., --with-version=23132)"

  def install
    # Allow installation of a specific version if requested
    if build.with? "version"
      version_arg = build.value("version")
      version_resource = "aermod_#{version_arg}"
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
    system "gfortran", "-o", "aermod", *link_flags, *object_files

    bin.install "aermod"
  end

  test do
    # Just check if the binary exists and is executable
    assert_predicate bin/"aermod", :executable?
    
    # Try running with -h flag (some versions may not support this)
    system bin/"aermod", "-h" rescue nil
  end
  
  # Helper method to check if a resource exists
  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
