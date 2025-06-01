require "English"
class Aermod < Formula
  require "English"

  desc "EPA air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  version "24142"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  license :public_domain

  option "without-bounds-check", "Disable runtime bounds checking for faster production builds"
  option "with-version", "Specify a version to install (e.g., --with-version=23132)"

  depends_on "gcc" => :build

  resource "aermod_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250601/aermod_24142.zip"
    sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  end

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
    compile_flags = ["-O2", "-fno-common"] # Add -fno-common to prevent duplicate symbols
    compile_flags += %w[-fbounds-check -Wuninitialized] if build.with?("bounds-check")
    link_flags = %w[-O2]

    # Clean up any existing object files to prevent conflicts
    rm Dir["*.o", "*.mod"]

    # Check if we have a batch file to use as reference
    bat_file = "#{source_dir}/gfortran-aermod.bat"

    # Track compiled object files to avoid duplicates
    compiled_objects = Set.new

    if File.exist?(bat_file)
      ohai "Found gfortran-aermod.bat file, analyzing it for compilation steps"
      bat_content = File.read(bat_file)

      # Find both compilation and linking commands
      compile_commands = []
      link_command = nil

      # Extract compile commands in order
      bat_content.each_line do |line|
        if line.match?(/gfortran\s+-c.*\.f/i)
          file_match = line.match(/\s+([a-zA-Z0-9_]+\.f[90]*)$/i)
          compile_commands << file_match[1] if file_match
        elsif line.match?(/gfortran.*\.o/i)
          link_command = line
        end
      end

      # If we found compile commands, use them
      if compile_commands.any?
        ohai "Found #{compile_commands.size} compile commands in batch file"
        source_files = compile_commands

        # If we found a link command, check if it specifies the object files in a specific order
        if link_command
          ohai "Found link command, analyzing object file order"
          link_objects = link_command.scan(/\s+([a-zA-Z0-9_]+\.o)\b/i).flatten

          if link_objects.any?
            ohai "Using object file order from link command: #{link_objects.join(", ")}"
            # Convert back to source file names for compilation - try both .f and .f90 extensions
            source_files_from_link = []
            link_objects.each do |obj|
              base_name = obj.sub(/\.o$/, "")
              f_file = "#{base_name}.f"
              f90_file = "#{base_name}.f90"

              if File.exist?(f_file)
                source_files_from_link << f_file
              elsif File.exist?(f90_file)
                source_files_from_link << f90_file
              else
                ohai "Could not find source file for #{obj}, will try #{f_file} in compilation"
                source_files_from_link << f_file # Default to .f extension
              end
            end

            # Make sure we have all files - add any missing ones from compile_commands
            missing_files = compile_commands - source_files_from_link
            if missing_files.any?
              ohai "Adding #{missing_files.size} files not in link command"
              source_files = source_files_from_link + missing_files
            else
              source_files = source_files_from_link
            end
          end
        end
      else
        ohai "Could not parse compile commands from batch file, using default ordering"
        source_files = Dir["*.f", "*.f90"].sort
      end
    else
      # Define the exact compilation order based on the batch file
      ohai "No batch file found, using predefined compilation order"

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

      ohai "Compile order: #{source_files.join(", ")}"
    end

    # Stop if no source files found
    odie "No source files found. Check ZIP structure." if source_files.empty?

    ENV.deparallelize

    # Compile all files in the determined order
    object_files = []
    source_files.each do |src|
      # Skip files that don't exist (in case we extracted names from a batch file)
      next unless File.exist?(src)

      obj_name = File.basename(src, File.extname(src)) + ".o"

      # Skip if we've already compiled this file
      if compiled_objects.include?(obj_name)
        ohai "Skipping duplicate compilation of #{src}"
        next
      end

      # Make sure we can find module files during compilation
      ohai "Compiling #{src}"
      system "gfortran", "-c", "-J.", *compile_flags, src

      # Check if compilation succeeded
      unless $CHILD_STATUS.success?
        ohai "Failed to compile #{src}, checking for the file..."
        system "ls", "-la", src if File.exist?(src)
        odie "Compilation failed for #{src}"
      end

      # Add to our tracking sets
      compiled_objects.add(obj_name)
      object_files << obj_name if File.exist?(obj_name)
    end

    odie "No object files were generated. Compilation failed." if object_files.empty?

    # Ensure no duplicate object files in the link step
    unique_object_files = object_files.uniq

    # Debug output to show what we're linking
    ohai "Linking #{unique_object_files.size} object files: #{unique_object_files.join(", ")}"

    # Link only unique object files
    system "gfortran", "-o", "aermod", *link_flags, *unique_object_files

    # Handle the executable
    mv "aermod.exe", "aermod" if File.exist?("aermod.exe")

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
