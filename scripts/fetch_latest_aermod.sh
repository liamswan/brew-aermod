#!/usr/bin/env bash
# Fetch the latest AERMOD source code and store its checksum
# Usage: ./scripts/fetch_latest_aermod.sh [VERSION]
# If VERSION is not supplied, attempt to scrape the latest release number from
the EPA SCRAM page.

set -euo pipefail

BASE_URL="https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod"
SCRAM_PAGE="https://www.epa.gov/scram/air-quality-dispersion-modeling-preferred-and-recommended-models#aermod"

if [[ $# -gt 0 ]]; then
  VERSION="$1"
else
  VERSION=$(curl -fsSL "$SCRAM_PAGE" | grep -oE 'Source Code \(v[0-9]+\) \(ZIP\)' | head -n1 | grep -oE '[0-9]+')
fi

ARCHIVE="Source Code (v${VERSION}) (ZIP)"
URL="${BASE_URL}/${ARCHIVE}"

mkdir -p downloads checksums

out_zip="downloads/aermod_${VERSION}.zip"

curl -L -o "$out_zip" "$URL"

sha256sum "$out_zip" | awk '{print $1 "  aermod_${VERSION}.zip"}' > "checksums/aermod_${VERSION}.sha256"

echo "Downloaded $out_zip and wrote checksum to checksums/aermod_${VERSION}.sha256"

echo "Add the new files to git:" >&2
echo "  git add $out_zip checksums/aermod_${VERSION}.sha256" >&2

