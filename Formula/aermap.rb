class Aermap < Formula
  desc "EPA AERMAP terrain processor (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap"
  version "24142"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  sha256 "4b34b39fe0039db114e3e78e3b6faa4797a5f8ee8ca0771db030a9b93ab3bed6"

  resource "aermap_24142" do
    url "https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermap_24142.zip"
    sha256 "4b34b39fe0039db114e3e78e3b6faa4797a5f8ee8ca0771db030a9b93ab3bed6"
  end

  depends_on "gcc" => :build

  option "without-bounds-check", "Disable runtime bounds checking"
  option "with-version", "Specify a version to install (e.g., --with-version=24142)"

  def install
    if build.with?("version")
      version_arg = build.value("version")
      version_resource = "aermap_#{version_arg}"
      if !resource_exists?(version_resource)
        odie("Version #{version_arg} is not available. Please choose a valid version or omit the --with-version option.")
      end
      resource(version_resource).stage { buildpath.install(Dir["*"]) }
    end

    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"
    compile_flags = ["-O2"]
    compile_flags += %w[-fbounds-check -Wuninitialized] if build.with?("bounds-check")
    link_flags = %w[-O2]

    source_files = Dir["*.f", "*.f90"].sort
    ENV.deparallelize
    source_files.each do |src|
      system("gfortran", "-c", *compile_flags, src)
    end

    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system("gfortran", "-o", "aermap", *link_flags, *object_files)

    bin.install("aermap")
  end

  test do
    assert_predicate(bin/"aermap", :executable?)
    # Test that aermap runs, but ignore the exit status since it will exit non-zero without input
    system(bin/"aermap", "-h") rescue nil
  end

  def resource_exists?(name)
    resources.key?(name.to_sym)
  end
end
