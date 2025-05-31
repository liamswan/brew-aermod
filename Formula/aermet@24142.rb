class AermetAT24142 < Formula
  desc "EPA meteorological preprocessor for AERMOD (built from source)"
  homepage "https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet"
  license :public_domain
  require "English"
  require "set"
  version "24142"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  sha256 "0e13af282c990dd08ec535d9476b850b559fe190a48942f2d0e2be705b43fab2"

  resource "aermet_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermet_24142.zip"
    sha256 "0e13af282c990dd08ec535d9476b850b559fe190a48942f2d0e2be705b43fab2"
  end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking"
  option "with-version", "Specify a version to install (e.g., --with-version=24142)"

  def install
    # Stage the specific version resource if requested
    if build.with?("version")
      version_arg = build.value("version")
      version_resource = "aermet_#{version_arg}"
      odie("Version #{version_arg} is not available. Please choose a valid version or omit the --with-version option.") unless resource_exists?(version_resource)
      resource(version_resource).stage { buildpath.install(Dir["*"]) }
    end

    # Extract files from aermet_source_code directory if it exists
    source_dir = "aermet_source_code_#{version}"
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

    # Define the compilation order based on the batch file
    # This follows the order in gfortran-aermet_allwarn.bat
    ordered_modules = %w[
      mod_file_units.f90
      mod_main1.f90
      mod_upperair.f90
      mod_surface.f90
      mod_onsite.f90
      mod_pbl.f90
      mod_read_input.f90
      mod_reports.f90
      mod_misc.f90
    ]

    # Get all source files
    all_source_files = Dir["*.f", "*.f90"].sort

    # Filter to only include files that exist
    ordered_modules = ordered_modules.select { |f| all_source_files.include?(f) }

    # Add any remaining files not in our ordered list
    remaining_files = all_source_files - ordered_modules
    source_files = ordered_modules + remaining_files

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
    system "gfortran", "-o", "aermet", *link_flags, *object_files

    # Install
    bin.install "aermet"
  end

  test do
    assert_predicate bin/"aermet", :executable?
    assert_match "AERMET", shell_output("#{bin}/aermet -h 2>&1", 1)
  end

  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
