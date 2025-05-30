#!/usr/bin/env bash
# Test AERMOD compilation

set -euo pipefail

# Work in a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Working in temporary directory: $TEMP_DIR"
cd "$TEMP_DIR"

# Download and extract the source
echo "Downloading AERMOD source..."
curl -k -L -o aermod_source.zip "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
unzip -q aermod_source.zip

# Get the directory name
SOURCE_DIR=$(find . -type d -name "aermod_source_code_*" | head -1)
if [ -z "$SOURCE_DIR" ]; then
  echo "Error: Could not find aermod_source_code directory"
  exit 1
fi

echo "Found source directory: $SOURCE_DIR"
cd "$SOURCE_DIR"

# Create the compilation script based on the batch file
echo "Creating compilation script..."
cat > aermod_compile.sh << 'EOF'
#!/bin/bash
set -e

COMPILE_FLAGS="-fbounds-check -Wuninitialized -O2"
LINK_FLAGS="-O2"

# Compile in the specific order from the batch file
gfortran -c $COMPILE_FLAGS modules.f    
gfortran -c $COMPILE_FLAGS grsm.f 
gfortran -c $COMPILE_FLAGS aermod.f   
gfortran -c $COMPILE_FLAGS setup.f    
gfortran -c $COMPILE_FLAGS coset.f    
gfortran -c $COMPILE_FLAGS soset.f    
gfortran -c $COMPILE_FLAGS reset.f    
gfortran -c $COMPILE_FLAGS meset.f    
gfortran -c $COMPILE_FLAGS ouset.f    
gfortran -c $COMPILE_FLAGS inpsum.f   
gfortran -c $COMPILE_FLAGS metext.f   
gfortran -c $COMPILE_FLAGS iblval.f   
gfortran -c $COMPILE_FLAGS siggrid.f  
gfortran -c $COMPILE_FLAGS tempgrid.f 
gfortran -c $COMPILE_FLAGS windgrid.f 
gfortran -c $COMPILE_FLAGS calc1.f    
gfortran -c $COMPILE_FLAGS calc2.f    
gfortran -c $COMPILE_FLAGS prise.f    
gfortran -c $COMPILE_FLAGS arise.f    
gfortran -c $COMPILE_FLAGS prime.f    
gfortran -c $COMPILE_FLAGS sigmas.f   
gfortran -c $COMPILE_FLAGS pitarea.f  
gfortran -c $COMPILE_FLAGS uninam.f 
gfortran -c $COMPILE_FLAGS output.f   
gfortran -c $COMPILE_FLAGS evset.f    
gfortran -c $COMPILE_FLAGS evcalc.f   
gfortran -c $COMPILE_FLAGS evoutput.f
gfortran -c $COMPILE_FLAGS rline.f 
gfortran -c $COMPILE_FLAGS bline.f 

# Link all object files
gfortran -o aermod $LINK_FLAGS modules.o grsm.o aermod.o setup.o coset.o soset.o reset.o meset.o ouset.o inpsum.o metext.o iblval.o siggrid.o tempgrid.o windgrid.o calc1.o calc2.o prise.o arise.o prime.o sigmas.o pitarea.o uninam.o output.o evset.o evcalc.o evoutput.o rline.o bline.o

# Clean up object files and module files
rm -f *.o
rm -f *.mod
EOF

chmod +x aermod_compile.sh

echo "Running compilation script..."
./aermod_compile.sh

if [ -f "aermod" ]; then
  echo "AERMOD compiled successfully!"
  echo "Testing AERMOD executable..."
  ./aermod || true  # It will exit with error code but should show usage info
else
  echo "Error: AERMOD compilation failed"
  exit 1
fi

echo "Cleaning up..."
cd /tmp
rm -rf "$TEMP_DIR"

echo "Test completed successfully!"
