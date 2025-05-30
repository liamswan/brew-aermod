#!/usr/bin/env bash
# Fetch the latest AERMAP source code and store its checksum
# Usage: ./scripts/fetch_latest_aermap.sh [VERSION]
#        ./scripts/fetch_latest_aermap.sh --version-only
#        ./scripts/fetch_latest_aermap.sh --manual-version=VERSION --manual-checksum=CHECKSUM
# If VERSION is not supplied, attempt to scrape the latest release number from the EPA SCRAM page.
# If --version-only is supplied, only output the latest version number and exit.
# If --manual-version and --manual-checksum are supplied, use those values instead of downloading.

set -euo pipefail

# Error handling function
error_exit() {
  echo "ERROR: $1" >&2
  exit 1
}

# Function to extract version using multiple patterns
extract_version() {
  local html_content="$1"
  local version=""
  
  # Try multiple patterns to extract version
  for pattern in 'AERMAP Source Code \(v([0-9]+)\)' 'AERMAP Source Code.*v([0-9]+)' 'AERMAP.*([0-9]{5})'; do
    version=$(echo "$html_content" | grep -oE "$pattern" | head -n1 | grep -oE '[0-9]+')
    if [[ -n "$version" ]]; then
      echo "$version"
      return 0
    fi
  done
  
  # If we get here, we couldn't find a version
  return 1
}

BASE_URL="https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap"
SCRAM_PAGE="https://www.epa.gov/scram/air-quality-dispersion-modeling-related-model-support-programs#aermap"
MANUAL_CHECKSUM=""

# Handle manual version and checksum flags
if [[ $# -gt 0 && "$1" =~ --manual-version=([0-9]+) ]]; then
  VERSION="${BASH_REMATCH[1]}"
  shift
  
  if [[ $# -gt 0 && "$1" =~ --manual-checksum=([a-f0-9]+) ]]; then
    MANUAL_CHECKSUM="${BASH_REMATCH[1]}"
    shift
  else
    error_exit "When using --manual-version, you must also provide --manual-checksum"
  fi
  
  echo "Using manually specified version $VERSION with checksum $MANUAL_CHECKSUM"
  
  # Create directories if they don't exist
  mkdir -p downloads checksums
  
  # Write the manual checksum to a file
  echo "$MANUAL_CHECKSUM" > "checksums/aermap_${VERSION}.sha256"
  echo "Wrote manual checksum to checksums/aermap_${VERSION}.sha256"
  exit 0
fi

# Handle special --version-only flag
if [[ $# -gt 0 && "$1" == "--version-only" ]]; then
  # Download the page content
  HTML_CONTENT=$(curl -fsSL "$SCRAM_PAGE" || error_exit "Failed to download EPA SCRAM page")
  
  # Extract version using multiple patterns
  VERSION=$(extract_version "$HTML_CONTENT")
  
  if [[ -z "$VERSION" ]]; then
    error_exit "Failed to extract version from EPA SCRAM page. Website structure may have changed."
  fi
  
  echo "$VERSION"
  exit 0
fi

if [[ $# -gt 0 ]]; then
  VERSION="$1"
else
  # Download the page content
  HTML_CONTENT=$(curl -fsSL "$SCRAM_PAGE" || error_exit "Failed to download EPA SCRAM page")
  
  # Extract version using multiple patterns
  VERSION=$(extract_version "$HTML_CONTENT")
  
  if [[ -z "$VERSION" ]]; then
    error_exit "Failed to extract version from EPA SCRAM page. Website structure may have changed."
  fi
fi

# Create a properly encoded URL for the source code
URL="${BASE_URL}/aermap_source.zip"

mkdir -p downloads checksums

out_zip="downloads/aermap_${VERSION}.zip"

echo "Downloading AERMAP version $VERSION from $URL..."

# Download the file, allow insecure connections
curl -k -L --output "$out_zip" "$URL" || error_exit "Failed to download $URL"

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [[ ! -s "$out_zip" ]]; then
  error_exit "Downloaded file is empty. Please check the URL."
fi

# Check if it's actually a ZIP file and not an HTML error page
if grep -q "<!DOCTYPE html>" "$out_zip"; then
  error_exit "Downloaded file appears to be an HTML page, not a ZIP file. The URL may be incorrect or the server may be returning an error."
fi

# Generate SHA256 checksum
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  CHECKSUM=$(shasum -a 256 "$out_zip" | awk '{print $1}')
  if [[ -z "$CHECKSUM" ]]; then
    error_exit "Failed to calculate checksum on macOS"
  fi
  echo "$CHECKSUM" > "checksums/aermap_${VERSION}.sha256"
else
  # Linux
  CHECKSUM=$(sha256sum "$out_zip" | awk '{print $1}')
  if [[ -z "$CHECKSUM" ]]; then
    error_exit "Failed to calculate checksum on Linux"
  fi
  echo "$CHECKSUM" > "checksums/aermap_${VERSION}.sha256"
fi

echo "Downloaded $out_zip and wrote checksum to checksums/aermap_${VERSION}.sha256"
echo "Checksum: $CHECKSUM"

echo "Add the new files to git:" >&2
echo "  git add $out_zip checksums/aermap_${VERSION}.sha256" >&2
