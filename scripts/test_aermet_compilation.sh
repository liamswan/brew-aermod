#!/usr/bin/env bash
# Test AERMET compilation

set -euo pipefail

# Work in a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Working in temporary directory: $TEMP_DIR"
cd "$TEMP_DIR"

# Download and extract the source
echo "Downloading AERMET source..."
curl -k -L -o aermet_source.zip "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
unzip -q aermet_source.zip

# Get the directory name
SOURCE_DIR=$(find . -type d -name "aermet_source_code_*" | head -1)
if [ -z "$SOURCE_DIR" ]; then
  echo "Error: Could not find aermet_source_code directory"
  exit 1
fi

echo "Found source directory: $SOURCE_DIR"
cd "$SOURCE_DIR"

# Create the compilation script based on the batch file
echo "Creating compilation script..."
cat > aermet_compile.sh << 'EOF'
#!/bin/bash
set -e

COMPILE_FLAGS="-fbounds-check -Wuninitialized -O2"
LINK_FLAGS="-O2"

# Compile in the specific order from the batch file
gfortran -c -J. $COMPILE_FLAGS mod_file_units.f90
gfortran -c -J. $COMPILE_FLAGS mod_main1.f90
gfortran -c -J. $COMPILE_FLAGS mod_upperair.f90
gfortran -c -J. $COMPILE_FLAGS mod_surface.f90
gfortran -c -J. $COMPILE_FLAGS mod_onsite.f90
gfortran -c -J. $COMPILE_FLAGS mod_pbl.f90
gfortran -c -J. $COMPILE_FLAGS mod_read_input.f90
gfortran -c -J. $COMPILE_FLAGS mod_reports.f90
gfortran -c -J. $COMPILE_FLAGS mod_misc.f90
gfortran -c -J. $COMPILE_FLAGS aermet.f90

# Link all object files
gfortran -o aermet $LINK_FLAGS mod_file_units.o mod_main1.o mod_upperair.o mod_surface.o mod_onsite.o mod_pbl.o mod_read_input.o mod_reports.o mod_misc.o aermet.o

# Clean up object files and module files
rm -f *.o
rm -f *.mod
EOF

chmod +x aermet_compile.sh

echo "Running compilation script..."
./aermet_compile.sh

if [ -f "aermet" ]; then
  echo "AERMET compiled successfully!"
  echo "Testing AERMET executable..."
  ./aermet -h || true  # It will exit with error code but should show usage info
else
  echo "Error: AERMET compilation failed"
  exit 1
fi

echo "Cleaning up..."
cd /tmp
rm -rf "$TEMP_DIR"

echo "Test completed successfully!"
