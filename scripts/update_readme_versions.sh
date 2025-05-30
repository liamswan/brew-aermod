#!/usr/bin/env bash
# update_readme_versions.sh
# Script to automatically update the README.md file with the latest AERMOD suite versions
# This can be run manually or integrated into CI/CD pipeline

set -euo pipefail

# Script directory and repository root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
README_PATH="$REPO_ROOT/README.md"

# Get the latest versions using the existing fetch scripts (with --version-only flag)
get_latest_version() {
  local program=$1
  local version
  
  if [[ -f "$SCRIPT_DIR/fetch_latest_$program.sh" ]]; then
    version=$("$SCRIPT_DIR/fetch_latest_$program.sh" --version-only)
    echo "$version"
  else
    echo "ERROR: Script fetch_latest_$program.sh not found" >&2
    return 1
  fi
}

# Get versions for all components
AERMOD_VERSION=$(get_latest_version "aermod")
AERMET_VERSION=$(get_latest_version "aermet")
AERMAP_VERSION=$(get_latest_version "aermap")

# Determine the "main" version to show in the README
# Use AERMOD version as the primary version
MAIN_VERSION="$AERMOD_VERSION"

# Current date for the "as of" line
CURRENT_DATE=$(date "+%B %Y")

# Create temporary file for the updated README
TEMP_README=$(mktemp)

# Update the README file
sed -E "s/- Latest stable version: [0-9]+ \(as of [A-Za-z]+ [0-9]+\)/- Latest stable version: $MAIN_VERSION (as of $CURRENT_DATE)/" "$README_PATH" > "$TEMP_README"

# Update versioned installation lines
sed -i '' -E "s/brew install aermod@[0-9]+/brew install aermod@$AERMOD_VERSION/" "$TEMP_README"
sed -i '' -E "s/brew install aermet@[0-9]+/brew install aermet@$AERMET_VERSION/" "$TEMP_README"
sed -i '' -E "s/brew install aermap@[0-9]+/brew install aermap@$AERMAP_VERSION/" "$TEMP_README"

# Copy the updated file back to the original
mv "$TEMP_README" "$README_PATH"

echo "Updated README.md with latest versions:"
echo "  AERMOD: $AERMOD_VERSION"
echo "  AERMET: $AERMET_VERSION"
echo "  AERMAP: $AERMAP_VERSION"
