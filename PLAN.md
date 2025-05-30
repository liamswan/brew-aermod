# Automated Installation of AERMOD, AERMET, and AERMAP via Homebrew

Installing the AERMOD dispersion model and its preprocessors AERMET (meteorological data) and AERMAP (terrain data) from source can be streamlined using Homebrew formulas. This guide provides a step-by-step plan to compile and install the latest EPA versions of these tools on macOS and Linux with minimal user intervention. We will build each component from official EPA source code using gfortran (from GCC) and Homebrew, and also define a combined "suite" formula for convenience. Version management and cross-platform notes are included, referencing the UBC installation guide for best practices.

## Prerequisites and Setup

Before writing the formulas, ensure the following prerequisites are in place:

* Homebrew is installed on your system (on macOS `/usr/local/Homebrew`, on Linux typically `/home/linuxbrew/.linuxbrew`). This provides the package manager framework.
* **Developer Tools**: On macOS, install Xcode Command Line Tools (for basic compilation tools). On Linux, ensure development tools are available (Homebrew will also provide needed compilers).
* **GFortran compiler**: We will use gfortran (via GCC). If you don't have it, Homebrew can supply it. The formulas will declare a dependency on Homebrew's GCC, which includes gfortran. (You can verify if gfortran is present by running `gfortran --version`.)

**Cross-Platform Note**: Homebrew's GCC works on both macOS (using Apple Clang for C/C++ and GCC's gfortran for Fortran) and Linux. The installation process will be nearly identical on both platforms. Ensure Homebrew's binary directory is in your PATH (usually done by Homebrew's installer). No other external dependencies are needed since AERMOD, AERMET, and AERMAP are self-contained Fortran programs.

## Writing Homebrew Formulas for Individual Tools

We will create three Homebrew formula files – one each for AERMOD, AERMET, and AERMAP. Each formula automates downloading the official EPA source code, compiling it with gfortran, and installing the resulting binary. The formulas will also handle any necessary compilation flags and dependencies (like ensuring GCC/gfortran is available).

**General approach**: In each formula's install method, we use system calls to run gfortran. We compile all source files and then link them into the final executable. This replicates the manual compilation steps outlined in the UBC guide, but in an automated fashion. The formulas will name the installed executables without the ".exe" extension for convenience (on UNIX systems the .exe extension is not required).

We also include versioning in the formula (using the EPA's version code or release year for reference) and a SHA256 checksum for source integrity. When a new official version is released, updating the formula's URL, version, and SHA256 will allow Homebrew to install the new version. Users can also pin a version if needed (covered later).

### Homebrew Formula for AERMOD

Create a file `aermod.rb` (in a tap repository or Homebrew's local formula directory) with contents similar to:

```ruby
class Aermod < Formula
  desc "EPA AERMOD air dispersion model (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  version "23132"  # Example version code (e.g., 23132 corresponds to the EPA release)
  sha256 "INSERT_SHA256_HERE"  # TODO: update with the actual SHA256 of aermod_source.zip

  depends_on "gcc" => :build   # Ensure gfortran (via GCC) is available for compilation

  def install
    # Ensure we use gfortran from Homebrew
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"

    # Define Fortran compile flags (from UBC guide recommendations)
    compile_flags = %w[-fbounds-check -Wuninitialized -O2]
    link_flags    = %w[-O2]

    # List of source files in the order they should be compiled (per EPA source and UBC guide)
    source_files = %w[
      modules.f grsm.f aermod.f setup.f coset.f soset.f reset.f meset.f ouset.f
      inpsum.f metext.f iblval.f siggrid.f tempgrid.f windgrid.f calc1.f calc2.f
      prise.f prime.f sigmas.f pitarea.f uniam.f output.f evset.f evcalc.f evoutput.f
      rline.f bline.f
    ]

    # Compile each Fortran source file to object code
    source_files.each do |src|
      system "gfortran", "-c", *compile_flags, src
    end

    # Link all object files into the final executable
    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system "gfortran", "-o", "aermod", *link_flags, *object_files

    # Install the binary into Homebrew's bin directory
    bin.install "aermod"
  end
end
```

**Explanation**: This formula fetches aermod_source.zip from the EPA site and compiles it. We explicitly compile each source file in the correct sequence before linking. The compile flags `-fbounds-check` and `-Wuninitialized` enable runtime bounds checking and warn about uninitialized variables (mirroring EPA's provided build flags), and `-O2` optimizes the code. (Additional flags like `-frecursive` or more warnings can be added as needed; the UBC guide's example uses `-O2` with basic warnings, while some tutorials use stricter flags.) We use Homebrew's GCC formula for gfortran to ensure consistency. The resulting aermod binary is installed to the Homebrew bin path.

**Note**: We omit the "-static" flag on macOS since static linking is not fully supported on macOS for GCC libraries. On Linux, you may choose to add `-static` to produce a self-contained binary, but this requires static libraries to be available. By default, dynamic linking will link against Homebrew's GCC libraries (Homebrew will keep track of these library dependencies). The formula as written will produce a 64-bit executable (Homebrew GCC targets 64-bit by default; the EPA build scripts specify `-m64` for 64-bit, which is implicitly true on modern systems).

### Homebrew Formula for AERMET

Similarly, create `aermet.rb`:

```ruby
class Aermet < Formula
  desc "EPA AERMET meteorological preprocessor (built from source)"
  homepage "https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  version "22112"  # Example version code (replace with actual if known/newer)
  sha256 "INSERT_SHA256_HERE"  # TODO: update with actual SHA256 of aermet_source.zip

  depends_on "gcc" => :build  # provides gfortran

  def install
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"
    compile_flags = %w[-fbounds-check -Wuninitialized -O2]
    link_flags    = %w[-O2]

    # Source files for AERMET (Fortran 90 source, compile order per EPA guidelines)
    source_files = %w[
      mod_file_units.f90 mod_main1.f90 mod_upperair.f90 mod_surface.f90 mod_onsite.f90
      mod_pbl.f90 mod_read_input.f90 mod_reports.f90 mod_misc.f90 aermet.f90
    ]

    source_files.each do |src|
      system "gfortran", "-c", *compile_flags, src
    end

    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system "gfortran", "-o", "aermet", *link_flags, *object_files

    bin.install "aermet"
  end
end
```

**Explanation**: The AERMET source comes as Fortran 90 files (.f90). We compile all module files (prefixed with mod_) first, then the main program. The order shown above is based on the official batch script (the UBC guide demonstrates compiling these in sequence). Linking produces the aermet executable. We use the same compile flags for consistency. The version "22112" here is an example (AERMET 22112 corresponds to a known 2022 release); update this if a newer code is available (the EPA might not explicitly version the zip file name, so version can be a date or code for clarity).

### Homebrew Formula for AERMAP

Create `aermap.rb`:

```ruby
class Aermap < Formula
  desc "EPA AERMAP terrain processor (built from source)"
  homepage "https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap"
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  version "18081"  # Example version code (replace with latest version identifier)
  sha256 "INSERT_SHA256_HERE"  # TODO: update with actual SHA256 of aermap_source.zip

  depends_on "gcc" => :build

  def install
    ENV["FC"] = Formula["gcc"].opt_bin/"gfortran"
    compile_flags = %w[-fbounds-check -Wuninitialized -O2]
    link_flags    = %w[-O2]

    # Source files for AERMAP (compile order from EPA scripts)
    source_files = %w[
      mod_main1.f mod_tifftags.f aermap.f
      sub_calchc.f sub_chkadj.f sub_chkext.f sub_demchk.f sub_nedchk.f sub_cnrcnv.f
      sub_demrec.f sub_demsrc.f sub_domcnv.f sub_initer_dem.f sub_initer_ned.f
      sub_nadcon.f sub_reccnv.f sub_recelv.f sub_srccnv.f sub_srcelv.f
      sub_utmgeo.f sub_read_tifftags.f
    ]

    source_files.each do |src|
      system "gfortran", "-c", *compile_flags, src
    end

    object_files = source_files.map { |f| File.basename(f, File.extname(f)) + ".o" }
    system "gfortran", "-o", "aermap", *link_flags, *object_files

    bin.install "aermap"
  end
end
```

**Explanation**: AERMAP's source includes many sub_*.f files for various subroutines and two mod_*.f files. We compile in the order defined by the official script (module files first, then main program and subs). The `-m64` flag used in EPA's scripts is not explicitly added here; Homebrew's gfortran will target the native architecture (64-bit on modern systems). The final executable aermap is installed. Update the version code (18081 here might correspond to a 2018 release – use a more current code if applicable) and SHA256 as needed.

Each of these formulas can be placed in a Homebrew Tap (e.g., your GitHub repo user/homebrew-aermod) or added locally. After writing them, run `brew install ./aermod.rb`, etc., to test locally or `brew tap user/aermod` and then `brew install user/aermod/aermod` if using a tap.

### Combined Installation (Meta-Formula for the Suite)

For convenience, you may create a meta-formula that bundles all three components. This formula will not download new source itself, but simply declare dependencies on the three formulas above. Installing this one formula will pull in AERMOD, AERMET, and AERMAP together.

For example, create `aermod-suite.rb` with the following:

```ruby
class AermodSuite < Formula
  desc "Meta-formula to install AERMOD and its preprocessors (AERMET, AERMAP)"
  homepage "https://www.epa.gov/scram"
  version "2025"  # a suite version label (e.g., year or meta version)
  # No direct url/download – this is a meta package

  depends_on "aermod"
  depends_on "aermet"
  depends_on "aermap"

  def install
    # Meta formula: nothing to compile, just ensure dependencies are installed.
    ohai "AERMOD suite is installed. Components: aermod, aermet, aermap."
  end
end
```

When this meta-formula is installed, Homebrew will resolve and install aermod, aermet, and aermap in one go. This is essentially a convenience and ensures all components are present at compatible versions. (If you prefer not to use a meta-formula, users can always install all three by listing them in one command: `brew install aermod aermet aermap` achieves the same end result.)

## Installation Steps for Users

With the formulas defined (and tapped or available locally), the installation becomes straightforward:

1. **Tap the repository** (if using a tap): For example, if you hosted these formulas on GitHub in user/homebrew-aermod, users would run:

   ```bash
   brew tap user/aermod
   ```

   This makes the aermod, aermet, aermap formulas available to brew.
2. **Install individually or as a bundle**:

   * To install individual components, run:

     ```bash
     brew install aermod
     brew install aermet
     brew install aermap
     ```

     This will download each source zip from EPA and compile it. Each formula will output a binary (aermod, aermet, aermap) into the Homebrew prefix's bin directory.
   * Or, to install everything in one command, use the meta-formula (if created):

     ```bash
     brew install aermod-suite
     ```

     Homebrew will then install all three tools in succession. After this, you will have all three executables available.
3. **Verify installation**: After installation, you can run `aermod -h` (or simply `aermod`) to check that the program executes. Each tool, when run without inputs, should print a message about missing input files or usage (for example, running `./aermod.exe` in the UBC guide gives an error about missing runstream input, which indicates the binary is functioning). You can also check the version by examining the output or documentation of each tool.

The installation is automated – users do not need to manually edit files or run gfortran themselves. All compilation steps (download, unzip, compile, link) are handled by Homebrew when the formula is installed.

## Version Management: Updating and Pinning

One advantage of using Homebrew for this installation is easy version management:

* **Updating to the latest version**: When the EPA releases a new official version of AERMOD/AERMET/AERMAP, you can update the formula(s) by changing the url, version, and sha256. For example, point to the new aermod_source.zip (if the EPA updates it in place or provides a new link) and update the SHA256 checksum. Increase the version string to reflect the new release (perhaps using the new version code or date). Then run `brew upgrade aermod` (and similarly for AERMET/AERMAP or just `brew upgrade aermod-suite`) to recompile and install the newer version. Homebrew will fetch and build the updated source.
* **Installing a specific version**: If you need to stick to an older version, you can maintain multiple formula versions (e.g., you could create aermod@22112 formula for an older release, with a different name and version). The user can then install `brew install aermod@22112`. This requires preserving the older formula in your tap. In practice, since EPA's link is generic, you might instead store the source archive of the older version elsewhere or use an official archived link (if available).
* **Pinning**: Homebrew allows pinning packages to prevent upgrades. If a user wants to freeze a working version, they can run `brew pin aermod` (and the same for others). This will prevent `brew upgrade` from updating that formula until it's unpinned (`brew unpin aermod`). Pinning is useful if you have validated a particular version of the model for regulatory work and do not want it to change unexpectedly.
* **Testing new versions**: If you update the formula but want to ensure it compiles on both macOS and Linux, use Homebrew's CI or test on both platforms. Our formulas specify portable Fortran code compilation, so they should work as long as gfortran is available. According to EPA/UBC notes, the compilation process is the same on Linux and Mac (just ensure line endings are correct, which Homebrew handles by using proper tools – e.g., the UBC guide notes converting Windows line endings to Unix with `set ff=unix`, but our approach using direct download/unzip avoids that issue).

## Differences Between macOS and Linux

The Homebrew formulas above are written to be cross-platform. Homebrew's build environment abstracts away most differences, but a few notes:

* **Compiler and Flags**: Both macOS and Linux will use the GNU Fortran compiler from the Homebrew gcc package. The compile flags chosen (`-fbounds-check -Wuninitialized -O2`) are compatible with both. We do not use platform-specific flags except ensuring 64-bit build. (In the EPA provided scripts, a Windows 64-bit build uses `-m64`, which is automatically satisfied in our environment as 64-bit is the default. We avoid using `-m64` explicitly to maintain compatibility with Apple Silicon Macs – on ARM, `-m64` is not applicable, but GCC on ARM will target the correct architecture by default.)
* **Static vs Dynamic Linking**: On Linux, the example compilation uses `-static` to produce a standalone binary. On macOS, static linking of libgfortran is not straightforward, so we link dynamically. Our formulas omit `-static`, resulting in dynamically-linked executables that depend on Homebrew's GCC libraries (Homebrew will keep the needed libraries installed). If truly static binaries are needed on Linux, you could modify the formula to add `-static` for Linux builds (e.g., if `OS.linux?` in the formula). However, for most users running the tools on the same system they installed with Homebrew, dynamic linking is fine.
* **File Extensions**: The EPA source and documentation refer to the executables as aermod.exe, aermet.exe, etc. On macOS/Linux, these are not Windows executables despite the .exe naming. In our installation, we drop the ".exe" extension for clarity – the installed commands are simply aermod, aermet, and aermap. Functionally, this makes no difference on UNIX systems. (If you prefer to keep the .exe in the name, you could adjust the formula to name the file with .exe, but it's uncommon on Mac/Linux. The UBC guide uses ./aermod.exe even on Linux, but that is optional naming.)
* **Runtime Behavior**: There are no significant runtime differences between macOS and Linux for these Fortran console programs. They read input files and produce output files in the same manner. Just ensure the working directory contains the needed input files (.inp files, weather data, etc.) when running the models. For example, running aermod will look for aermod.inp in the current directory and if not found, it will throw an error like "Error Opening Runstream Input File" – this is expected until you provide proper inputs.
* **Path Differences**: Homebrew on macOS installs binaries to `/usr/local/bin` (on Apple Silicon Macs, `/opt/homebrew/bin`), and on Linux to the Homebrew prefix (often `/home/linuxbrew/.linuxbrew/bin`). Ensure your shell's PATH includes the appropriate bin directory so you can invoke aermod, aermet, aermap directly.

By following this plan, users on both macOS and Linux can easily compile and install the latest official AERMOD, AERMET, and AERMAP tools from source with Homebrew. The process is automated and reproducible – from downloading the official EPA source code to applying the recommended compilation steps – all encapsulated in Homebrew formulas. Users can install each component individually or all at once, update to new versions when released, and manage versions to suit their project needs. This yields a clean, Homebrew-managed installation of the AERMOD modeling system with minimal manual effort.

## Sources and References

* [UBC EOAS AERMOD/AERMET/AERMAP 2024 Guide – step-by-step compilation instructions for Linux/macOS. ](https://www.eoas.ubc.ca/courses/atsc507/ADM/aermod/aermod_aermet_aermap_2024-v2.pdf)
* EPA SCRAM Site – official source code downloads for [AERMOD](https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod), [AERMET](https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet), and AERMAP.
* Envitrans/MeDH Blog – example of compiling AERMOD on Linux with gfortran (demonstrates gfortran command and flags).
* Stack Overflow discussion – confirming additional source files (e.g. rline.f, bline.f) needed for AERMOD compilation on macOS with Homebrew gfortran.
