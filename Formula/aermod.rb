class Aermod < Formula
  desc "EPA AERMOD air dispersion model (built from source)"
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
      if !resource_exists?(version_resource)
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
    
    # Prioritize using the batch file if it exists
    bat_file = "#{source_dir}/gfortran-aermod.bat"
    
    if File.exist?(bat_file)
      ohai "Found gfortran-aermod.bat file, using it as reference for compilation"
      # Parse the batch file to extract the compile order
      bat_content = File.read(bat_file)
      
      # Find all compiler commands in the batch file
      compile_commands = bat_content.scan(/gfortran\s+-c.*\.f/i).map do |cmd|
        # Extract just the filename from each compile command
        cmd.match(/\s+([a-zA-Z0-9_]+\.f[90]*)$/i)&.[](1)
      end.compact
      
      # If we found a compile order, use it
      if compile_commands.any?
        ohai "Found #{compile_commands.size} compile commands in batch file"
        source_files = compile_commands
      else
        ohai "Could not parse compile order from batch file, using default ordering"
        source_files = Dir["*.f", "*.f90"].sort
      end
    else
      # Try to determine a sensible compile order
      ohai "No batch file found, determining module dependencies"
      
      # First, compile modules.f which often contains basic definitions
      module_files = Dir["modules.f", "modules.f90", "*module*.f", "*module*.f90"]
      regular_files = Dir["*.f", "*.f90"].sort - module_files
      
      # Specific handling for known main1 module issue
      main_files = regular_files.select { |f| f =~ /main1/i }
      other_files = regular_files - main_files
      
      # Compile in this order: module files -> main1 files -> other files
      source_files = module_files + main_files + other_files
      
      ohai "Compile order: #{source_files.join(", ")}"
    end
    
    # Stop if no source files found
    if source_files.empty?
      odie "No source files found. Check ZIP structure."
    end
    
    ENV.deparallelize
    
    # Compile all files in the determined order
    source_files.each do |src|
      # Skip files that don't exist (in case we extracted names from a batch file)
      next unless File.exist?(src)
      
      # Make sure we can find module files during compilation
      system("gfortran", "-c", "-J.", *compile_flags, src)
      
      # Check if compilation succeeded
      unless $?.success?
        ohai "Failed to compile #{src}, checking for the file..."
        system("ls", "-la", src) if File.exist?(src)
        odie "Compilation failed for #{src}"
      end
    end

    # Link everything
    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
                             .select { |o| File.exist?(o) }
    
    if object_files.empty?
      odie "No object files were generated. Compilation failed."
    end
    
    system("gfortran", "-o", "aermod", *link_flags, *object_files)
    
    # Handle the executable
    if File.exist?("aermod.exe")
      mv "aermod.exe", "aermod"
    end
    
    # Install the final executable
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
