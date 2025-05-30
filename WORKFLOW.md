# AERMOD Formula Version Management Workflow

This document explains how to manage different versions of AERMOD using the `fetch_latest_aermod.sh` script and Homebrew formulas.

## Overview

The workflow consists of these steps:

1. Download source code and generate checksums
2. Update formula files with the new version and checksums
3. Test and publish the updated formulas

## Step 1: Download Source Code and Generate Checksums

The `scripts/fetch_latest_aermod.sh` script automates downloading the AERMOD source code and generating SHA-256 checksums.

```bash
# To download the latest version (auto-detected from EPA website):
./scripts/fetch_latest_aermod.sh

# To download a specific version:
./scripts/fetch_latest_aermod.sh 24142
```

This will:
- Create a `downloads` directory with the AERMOD source ZIP file (e.g., `downloads/aermod_24142.zip`)
- Create a `checksums` directory with the SHA-256 checksum (e.g., `checksums/aermod_24142.sha256`)

## Step 2: Update Formula Files

After downloading the source and generating checksums, update the formula files with the new version and checksum:

1. Open the formula file (`Formula/aermod.rb`)
2. Update the `version` field with the new version number
3. Update the `sha256` field with the content from the checksum file

```ruby
class Aermod < Formula
  # ...
  version "24142"  # Update this with the new version
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"  # Update this with the new checksum
  # ...
end
```

Repeat this process for `aermet.rb` and `aermap.rb` if you also downloaded and generated checksums for those components.

## Step 3: Commit and Push Changes

Add the downloaded files and updated formulas to version control:

```bash
git add downloads/aermod_*.zip checksums/aermod_*.sha256 Formula/*.rb
git commit -m "Update AERMOD to version 24142"
git push
```

## Managing Multiple Versions

### Using Versioned Formulas

For maintaining multiple versions simultaneously, create versioned formula files:

1. Copy the current formula to a versioned one:

```bash
cp Formula/aermod.rb Formula/aermod@24142.rb
```

2. Update the class name in the versioned formula:

```ruby
class AermodAT24142 < Formula
  # ...
end
```

3. Update the main formula to the newer version

Users can then install specific versions:

```bash
# Install the latest version
brew install aermod

# Install a specific version
brew install aermod@24142
```

### Using Resource Blocks (Alternative Approach)

For more complex cases, you can use resource blocks in the formula:

```ruby
class Aermod < Formula
  # ...
  
  # Default version
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  sha256 "72965f60b8ee5a43a2668ef648afd9057abe3023a8738f9ab37679217fdc5940"
  
  # Additional versions as resources
  resource "version_23132" do
    url "file://#{HOMEBREW_PREFIX}/Homebrew/Library/Taps/liamswan/homebrew-brew-aermod/downloads/aermod_23132.zip"
    sha256 "previous_version_checksum_here"
  end
  
  # Allow version selection via option
  option "with-version-23132", "Build with AERMOD version 23132"
  
  def install
    if build.with? "version-23132"
      resource("version_23132").stage { ... }
    else
      # Use the default version
    end
    # ...
  end
end
```

## Continuous Integration Considerations

When using checksums in your formula, CI builds will fail if:

1. The checksum doesn't match the downloaded file
2. The file URL becomes unavailable

To maintain a robust CI process:

1. Always commit the source ZIP files to the repository
2. Update the formulas to use the committed files when the EPA source is unavailable
3. Alternatively, host the files on a stable server or GitHub Releases

## References

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Ruby API](https://rubydoc.brew.sh/)
