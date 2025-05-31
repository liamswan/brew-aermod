# Automated Version Management for AERMOD Suite Homebrew Formulas

This document explains the automated workflow that checks for new releases of all AERMOD Suite components (AERMOD, AERMET, and AERMAP) weekly and updates the Homebrew formulas accordingly.

## Overview

We've set up a GitHub Actions workflow that runs weekly to:

1. Check for new releases of AERMOD, AERMET, and AERMAP on the EPA website
2. Download new releases when available
3. Update the formula files for each component
4. Create versioned formulas for specific versions
5. Create GitHub releases with the source code
6. Test the updated formulas

## How It Works

### Scheduled Checks

The workflow runs every Monday at 1:00 AM UTC. It performs the following steps:

1. **Version Check**: Compares the current versions in the formulas with the latest versions on the EPA website for all three components.
2. **Download Source**: If new versions are detected, it downloads the source code for each updated component.
3. **Update Formulas**: 
   - Updates the main formulas with the new version number and SHA-256 checksum
   - Adds the new version as a resource in the formula for version-specific installations
   - Creates versioned formulas for each component (e.g., `aermod@24142.rb`)
4. **Create Release**: Creates a GitHub release with the source code for all updated components.
5. **Test Formula**: Tests the updated formulas on macOS.

### Version Management

The formulas now support installing specific versions in two ways:

1. **Via Versioned Formula**: 
   ```bash
   brew install aermod@24142
   ```

2. **Via Version Option**:
   ```bash
   brew install aermod --with-version=24142
   ```

Each formula maintains a collection of resources for different versions, each with their own URL and SHA-256 checksum for verification.

## Configuration

The workflow is configured in `.github/workflows/weekly-version-check.yml`. Key configurable aspects include:

- **Schedule**: The `cron` expression in the workflow file determines when checks run
- **Formula Updates**: The workflow updates both the main formulas and creates versioned formulas
- **Release Creation**: The workflow creates a GitHub release for each update batch

## Directory Structure

After the workflow runs, the repository will have:

- `downloads/aermod_VERSION.zip`: AERMOD source code for each version
- `downloads/aermet_VERSION.zip`: AERMET source code for each version
- `downloads/aermap_VERSION.zip`: AERMAP source code for each version
- `checksums/aermod_VERSION.sha256`: SHA-256 checksums for each AERMOD version
- `checksums/aermet_VERSION.sha256`: SHA-256 checksums for each AERMET version
- `checksums/aermap_VERSION.sha256`: SHA-256 checksums for each AERMAP version
- `Formula/aermod.rb`: Main AERMOD formula (always points to latest version)
- `Formula/aermet.rb`: Main AERMET formula (always points to latest version)
- `Formula/aermap.rb`: Main AERMAP formula (always points to latest version)
- `Formula/aermod@VERSION.rb`: Version-specific AERMOD formulas
- `Formula/aermet@VERSION.rb`: Version-specific AERMET formulas
- `Formula/aermap@VERSION.rb`: Version-specific AERMAP formulas

## Benefits

This automated workflow provides several benefits:

1. **Always Current**: The formulas are always up-to-date with the latest EPA releases
2. **Version Control**: Users can install specific versions when needed
3. **Reproducibility**: Source code is preserved in the repository and GitHub releases
4. **Reliability**: The formulas don't depend on the EPA website for installation
5. **Comprehensive**: All three components (AERMOD, AERMET, AERMAP) are kept in sync

## Troubleshooting

If the workflow fails, check:

1. **EPA Website Changes**: The workflow relies on specific patterns on the EPA website to detect versions
2. **GitHub Actions Permissions**: Ensure the workflow has permission to create releases
3. **Branch Protection**: If you have branch protection rules, you may need to adjust them to allow the workflow to push changes

## Manual Intervention

If needed, you can always run the fetch scripts manually and update the formulas:

```bash
# Update AERMOD
./scripts/fetch_latest_aermod.sh
# Then edit Formula/aermod.rb with the new version and checksum

# Update AERMET
./scripts/fetch_latest_aermet.sh
# Then edit Formula/aermet.rb with the new version and checksum

# Update AERMAP
./scripts/fetch_latest_aermap.sh
# Then edit Formula/aermap.rb with the new version and checksum
```
