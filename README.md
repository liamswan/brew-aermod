[![Weekly AERMOD Suite Version Check](https://github.com/liamswan/homebrew-aermod/actions/workflows/weekly-version-check.yml/badge.svg?branch=main)](https://github.com/liamswan/homebrew-aermod/actions/workflows/weekly-version-check.yml)
[![CI](https://github.com/liamswan/homebrew-aermod/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/liamswan/homebrew-aermod/actions/workflows/ci.yml)
# Homebrew Tap for AERMOD Suite

This repository contains Homebrew formulas for the AERMOD air dispersion modeling system and its preprocessors. It allows macOS and Linux users to easily install the EPA's AERMOD, AERMET, and AERMAP tools using Homebrew.

## What is AERMOD?

AERMOD is the U.S. Environmental Protection Agency's (EPA) preferred regulatory air dispersion model for near-field applications. The AERMOD modeling system consists of:

- **AERMOD**: Air dispersion model
- **AERMET**: Meteorological data preprocessor
- **AERMAP**: Terrain data preprocessor

These tools are widely used for regulatory air quality modeling to assess the impact of pollution sources on ambient air quality.

## Installation

### Prerequisites

- [Homebrew](https://brew.sh/) package manager
- GCC with Fortran support (will be installed automatically as a dependency)

### Installing the Tap

```bash
brew tap liamswan/homebrew-aermod
```

### Installing Individual Components

```bash
brew install aermod
brew install aermet
brew install aermap
```

### Installing the Complete Suite

To install all components at once:

```bash
brew install aermod-suite
```

## Usage

After installation, the following commands will be available in your PATH:

- `aermod` - The AERMOD dispersion model
- `aermet` - The AERMET meteorological preprocessor
- `aermap` - The AERMAP terrain preprocessor

Each program can be run from the command line and will look for input files in the current directory.

### Basic Example

```bash
# Navigate to your project directory containing input files
cd /path/to/your/project

# Run AERMOD (requires aermod.inp in current directory)
aermod

# Run AERMET (requires aermet.inp in current directory)
aermet

# Run AERMAP (requires aermap.inp in current directory)
aermap
```

## Build Options

When installing, you can disable runtime bounds checking for improved performance:

```bash
brew install aermod --without-bounds-check
```

## Version Management

### Available Versions

The following versions are currently available:

- Latest stable version: 24142 (as of May 2025)
- Versioned installations:
  - `brew install aermod@24142`
  - `brew install aermet@24142`
  - `brew install aermap@24142`

By default, installing without a version specifier will give you the latest version.

### Updating to the Latest Version

To update to the latest version of the AERMOD suite:

```bash
brew update
brew upgrade aermod-suite
```

### Installing a Specific Version

If you need a specific version for regulatory purposes:

```bash
brew install aermod@24142
brew install aermet@24142
brew install aermap@24142
```

### Pinning a Version

If you need to keep a specific version for regulatory purposes:

```bash
brew pin aermod
brew pin aermet
brew pin aermap
```

To unpin when you're ready to upgrade:

```bash
brew unpin aermod
brew unpin aermet
brew unpin aermap
```

## Technical Details

These formulas compile the official EPA source code using gfortran (from GCC). The compilation process:

1. Downloads the official source code from the EPA website
2. Compiles all Fortran source files with appropriate flags
3. Links the object files into executables
4. Installs the binaries to your Homebrew prefix

By default, the formulas enable runtime bounds checking (`-fbounds-check`) and uninitialized variable warnings (`-Wuninitialized`) for safer development builds.

## License

This project is provided under the MIT License. The AERMOD suite itself is developed by the U.S. EPA and has its own licensing terms. Please refer to the EPA website for details on usage rights for the AERMOD software.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Sources and References

The following resources were used in developing this Homebrew tap:

* [UBC EOAS AERMOD/AERMET/AERMAP 2024 Guide](https://www.eoas.ubc.ca/courses/atsc507/ADM/aermod/aermod_aermet_aermap_2024-v2.pdf) - Detailed step-by-step compilation instructions for Linux/macOS
* [EPA SCRAM Site](https://www.epa.gov/scram) - Official source code downloads for:
  * [AERMOD](https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod)
  * [AERMET](https://www.epa.gov/scram/meteorological-processors-and-accessory-programs#aermet)
  * [AERMAP](https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap)
* Compilation approach based on EPA-provided build scripts and compiler flags
* Cross-platform support for both macOS and Linux via Homebrew's package management system
