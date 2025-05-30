#!/usr/bin/env bash
# Test AERMAP compilation

set -euo pipefail

# Work in a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Working in temporary directory: $TEMP_DIR"
cd "$TEMP_DIR"

# Download and extract the source
echo "Downloading AERMAP source..."
curl -k -L -o aermap_source.zip "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
unzip -q aermap_source.zip

# Get the directory name
SOURCE_DIR=$(find . -type d -name "aermap_source_code_*" | head -1)
if [ -z "$SOURCE_DIR" ]; then
  echo "Error: Could not find aermap_source_code directory"
  exit 1
fi

echo "Found source directory: $SOURCE_DIR"
cd "$SOURCE_DIR"

# Create the compilation script based on the batch file
echo "Creating compilation script..."
cat > aermap_compile.sh << 'EOF'
#!/bin/bash
set -e

COMPILE_FLAGS="-fbounds-check -Wuninitialized -O2"
LINK_FLAGS="-O2"

# Compile in the specific order from the batch file
gfortran -c -J. $COMPILE_FLAGS mod_main1.f
gfortran -c -J. $COMPILE_FLAGS mod_tifftags.f
gfortran -c -J. $COMPILE_FLAGS aermap.f
gfortran -c -J. $COMPILE_FLAGS sub_calchc.f
gfortran -c -J. $COMPILE_FLAGS sub_chkadj.f
gfortran -c -J. $COMPILE_FLAGS sub_chkext.f
gfortran -c -J. $COMPILE_FLAGS sub_demchk.f
gfortran -c -J. $COMPILE_FLAGS sub_nedchk.f
gfortran -c -J. $COMPILE_FLAGS sub_cnrcnv.f
gfortran -c -J. $COMPILE_FLAGS sub_demrec.f
gfortran -c -J. $COMPILE_FLAGS sub_demsrc.f
gfortran -c -J. $COMPILE_FLAGS sub_domcnv.f
gfortran -c -J. $COMPILE_FLAGS sub_initer_dem.f
gfortran -c -J. $COMPILE_FLAGS sub_initer_ned.f
gfortran -c -J. $COMPILE_FLAGS sub_nadcon.f
gfortran -c -J. $COMPILE_FLAGS sub_reccnv.f
gfortran -c -J. $COMPILE_FLAGS sub_recelv.f
gfortran -c -J. $COMPILE_FLAGS sub_srccnv.f
gfortran -c -J. $COMPILE_FLAGS sub_srcelv.f
gfortran -c -J. $COMPILE_FLAGS sub_utmgeo.f
gfortran -c -J. $COMPILE_FLAGS sub_read_tifftags.f

# Link all object files
gfortran -o aermap $LINK_FLAGS mod_main1.o mod_tifftags.o aermap.o sub_calchc.o sub_chkadj.o sub_chkext.o sub_demchk.o sub_nedchk.o sub_cnrcnv.o sub_demrec.o sub_demsrc.o sub_domcnv.o sub_initer_dem.o sub_initer_ned.o sub_nadcon.o sub_reccnv.o sub_recelv.o sub_srccnv.o sub_srcelv.o sub_utmgeo.o sub_read_tifftags.o

# Clean up object files and module files
rm -f *.o
rm -f *.mod
EOF

chmod +x aermap_compile.sh

echo "Running compilation script..."
./aermap_compile.sh

if [ -f "aermap" ]; then
  echo "AERMAP compiled successfully!"
  echo "Testing AERMAP executable..."
  ./aermap -h || true  # It will exit with error code but should show usage info
else
  echo "Error: AERMAP compilation failed"
  exit 1
fi

echo "Cleaning up..."
cd /tmp
rm -rf "$TEMP_DIR"

echo "Test completed successfully!"
