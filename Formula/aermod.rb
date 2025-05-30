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

    # Check if we need to convert the batch file to shell script
    bat_file = "#{source_dir}/gfortran-aermod.bat" if Dir.exist?(source_dir)
    if bat_file && File.exist?(bat_file)
      # Create a shell script based on the batch file
      bat_content = File.read(bat_file)
      sh_content = bat_content.gsub(/\r\n?/, "\n")  # Convert DOS to Unix line endings
      sh_content.gsub!(/%([^%]+)%/) { "$#{$1.downcase}" }  # Replace %VARS% with $vars
      sh_content.gsub!(/del /i, "rm -f ")  # Replace DEL with rm -f
      
      # Add shebang and export statements
      sh_content = "#!/bin/bash\nexport compile_flags=\"#{compile_flags.join(' ')}\"\nexport link_flags=\"#{link_flags.join(' ')}\"\n\n" + sh_content
      
      sh_file = "#{buildpath}/gfortran-aermod.sh"
      File.write(sh_file, sh_content)
      FileUtils.chmod(0755, sh_file)
      
      system(sh_file)
    else
      # Manual compilation if no batch file exists
      source_files = Dir["*.f", "*.f90"].sort
      if source_files.empty?
        odie "No source files found. Check ZIP structure."
      end
      
      ENV.deparallelize
      source_files.each do |src|
        system("gfortran", "-c", *compile_flags, src)
      end
      
      # Link everything
      object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
      system("gfortran", "-o", "aermod", *link_flags, *object_files)
    end
    
    # Handle the executable
    if File.exist?("aermod.exe")
      mv "aermod.exe", "aermod"
    end

    # Install
    bin.install("aermod")
  end

  test do
    assert_predicate bin/"aermod", :executable?
    assert_match "AERMOD", shell_output("#{bin}/aermod -h 2>&1", 1)
  end

  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
