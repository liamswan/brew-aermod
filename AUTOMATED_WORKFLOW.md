# Automated Version Management for AERMOD Homebrew Formula

This document explains the automated workflow that checks for new AERMOD releases weekly and updates the Homebrew formulas accordingly.

## Overview

We've set up a GitHub Actions workflow that runs weekly to:

1. Check for new AERMOD releases on the EPA website
2. Download new releases when available
3. Update the formula files
4. Create versioned formulas for specific versions
5. Create GitHub releases with the source code
6. Test the updated formula

## How It Works

### Scheduled Checks

The workflow runs every Monday at 1:00 AM UTC. It performs the following steps:

1. **Version Check**: Compares the current version in the formula with the latest version on the EPA website.
2. **Download Source**: If a new version is detected, it downloads the source code.
3. **Update Formulas**: Updates the main formula and creates a versioned formula.
4. **Create Release**: Creates a GitHub release with the source code.
5. **Test Formula**: Tests the updated formula on macOS.

### Manual Triggering

You can also manually trigger the workflow from the GitHub Actions tab for immediate checking and updating.

## Configuration

The workflow is configured in `.github/workflows/weekly-version-check.yml`. Key configurable aspects include:

- **Schedule**: The `cron` expression in the workflow file determines when checks run
- **Formula Updates**: The workflow updates both the main formula and creates a versioned formula
- **Release Creation**: The workflow creates a GitHub release for each new version

## Directory Structure

After the workflow runs, the repository will have:

- `downloads/aermod_VERSION.zip`: Source code for each version
- `checksums/aermod_VERSION.sha256`: SHA-256 checksums for each version
- `Formula/aermod.rb`: Main formula (always points to latest version)
- `Formula/aermod@VERSION.rb`: Version-specific formulas

## Benefits

This automated workflow provides several benefits:

1. **Always Current**: The formula is always up-to-date with the latest EPA releases
2. **Version Control**: Users can install specific versions when needed
3. **Reproducibility**: Source code is preserved in the repository and GitHub releases
4. **Reliability**: The formula doesn't depend on the EPA website for installation

## Troubleshooting

If the workflow fails, check:

1. **EPA Website Changes**: The workflow relies on specific patterns on the EPA website to detect versions
2. **GitHub Actions Permissions**: Ensure the workflow has permission to create releases
3. **Branch Protection**: If you have branch protection rules, you may need to adjust them to allow the workflow to push changes

## Manual Intervention

If needed, you can always run the `fetch_latest_aermod.sh` script manually and update the formulas:

```bash
./scripts/fetch_latest_aermod.sh
# Then edit Formula/aermod.rb with the new version and checksum
```
