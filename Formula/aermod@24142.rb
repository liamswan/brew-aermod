require 'English'
class AermodAT24142 < Formula
  desc "EPA air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  license :public_domain
  version "24142"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"

  resource "aermod_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod_24142.zip"
    sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking for faster production builds"
  option "with-version", "Specify a version to install (e.g., --with-version=23132)"

  def install
    # Stage the specific version resource if requested
    if build.with?("version")
      version_arg = build.value("version")
      version_resource = "aermod_#{version_arg}"
      unless resource_exists?(version_resource)
        odie("Version #{version_arg} is not available. Please choose a valid version or omit the --with-version option.")
      end
      resource(version_resource).stage { buildpath.install(Dir["*"]) }
    end

    # Extract files from aermod_source_code directory if it exists
    source_dir = "aermod_source_code_#{version}"
    if Dir.exist?(source_dir)
      Dir.chdir(source_dir) do
        buildpath.install(Dir["*.f", "*.f90"])
      end
    end

    # Compiler setup
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"
    compile_flags = ["-O2"]
    compile_flags += %w[-fbounds-check -Wuninitialized] if build.with?("bounds-check")
    link_flags = %w[-O2]

    # Define the exact compilation order based on the batch file
    # This is the standard order from gfortran-aermod.bat
    ordered_files = %w[
      modules.f
      grsm.f
      aermod.f
      setup.f
      coset.f
      soset.f
      reset.f
      meset.f
      ouset.f
      inpsum.f
      metext.f
      iblval.f
      siggrid.f
      tempgrid.f
      windgrid.f
      calc1.f
      calc2.f
      prise.f
      arise.f
      prime.f
      sigmas.f
      pitarea.f
      uninam.f
      output.f
      evset.f
      evcalc.f
      evoutput.f
      rline.f
      bline.f
    ]

    # Filter to only include files that exist
    all_source_files = Dir["*.f", "*.f90"]
    existing_ordered_files = ordered_files.select { |f| all_source_files.include?(f) }

    # Add any remaining files not in our ordered list
    remaining_files = all_source_files - existing_ordered_files
    source_files = existing_ordered_files + remaining_files

    if source_files.empty?
      odie "No source files found. Check ZIP structure."
    end

    ENV.deparallelize

    # Compile all files in the determined order
    source_files.each do |src|
      system "gfortran", "-c", "-J.", *compile_flags, src

      # Check if compilation succeeded
      unless $CHILD_STATUS.success?
        ohai "Failed to compile #{src}"
        system "ls", "-la", src if File.exist?(src)
        odie "Compilation failed for #{src}"
      end
    end

    # Link everything
    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system "gfortran", "-o", "aermod", *link_flags, *object_files

    # Install
    bin.install "aermod"
  end

  test do
    assert_predicate bin/"aermod", :executable?
    assert_match "AERMOD", shell_output("#{bin}/aermod -h 2>&1", 1)
  end

  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
