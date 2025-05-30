class AermapAT24142 < Formula
  desc "EPA AERMAP terrain processor (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap"
  license :public_domain
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  version "24142"
  sha256 "4b34b39fe0039db114e3e78e3b6faa4797a5f8ee8ca0771db030a9b93ab3bed6"

  resource "aermap_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermap_24142.zip"
    sha256 "4b34b39fe0039db114e3e78e3b6faa4797a5f8ee8ca0771db030a9b93ab3bed6"
  end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking"
  option "with-version", "Specify a version to install (e.g., --with-version=24142)"

  def install
    # Stage the specific version resource if requested
    if build.with?("version")
      version_arg = build.value("version")
      version_resource = "aermap_#{version_arg}"
      unless resource_exists?(version_resource)
        odie("Version #{version_arg} is not available. Please choose a valid version or omit the --with-version option.")
      end
      resource(version_resource).stage { buildpath.install(Dir["*"]) }
    end

    # Extract files from aermap_source_code directory if it exists
    source_dir = "aermap_source_code_#{version}"
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
    # This is the standard order from gfortran-aermap-64bit.bat
    ordered_files = %w[
      mod_main1.f
      mod_tifftags.f
      aermap.f
      sub_calchc.f
      sub_chkadj.f
      sub_chkext.f
      sub_demchk.f
      sub_nedchk.f
      sub_cnrcnv.f
      sub_demrec.f
      sub_demsrc.f
      sub_domcnv.f
      sub_initer_dem.f
      sub_initer_ned.f
      sub_nadcon.f
      sub_reccnv.f
      sub_recelv.f
      sub_srccnv.f
      sub_srcelv.f
      sub_utmgeo.f
      sub_read_tifftags.f
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
      system("gfortran", "-c", "-J.", *compile_flags, src)
      
      # Check if compilation succeeded
      unless $?.success?
        ohai "Failed to compile #{src}"
        system("ls", "-la", src) if File.exist?(src)
        odie "Compilation failed for #{src}"
      end
    end

    # Link everything
    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system("gfortran", "-o", "aermap", *link_flags, *object_files)

    # Install
    bin.install("aermap")
  end

  test do
    assert_predicate bin/"aermap", :executable?
    assert_match "AERMAP", shell_output("#{bin}/aermap -h 2>&1", 1)
  end

  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
