# AERMET, AERMAP, and AERMOD Compilation Fixes

## Issues Identified

### AERMET Compilation Issues
1. The error message indicated a missing `upperair.mod` file, which is required by `mod_misc.f90` during compilation.
2. The root cause was the compilation order - in Fortran, modules must be compiled in the correct dependency order.
3. The original formula tried to determine compilation order by:
   - Parsing the batch file if available
   - Using a "sensible" order based on filename patterns if not

### AERMAP Potential Issues
Similar issues could occur with AERMAP compilation if modules are not compiled in the correct order.

### AERMOD Considerations
AERMOD also requires specific compilation order, particularly with the `modules.f` file which needs to be compiled first.

## Solutions Implemented

### AERMET Formula Fixes
1. Examined the original batch file (`gfortran-aermet_allwarn.bat`) to identify the correct compilation order.
2. Found that `mod_upperair.f90` must be compiled before `mod_misc.f90`.
3. Updated both formulas (`aermet.rb` and `aermet@24142.rb`) to ensure:
   - Proper handling of the batch file if available
   - A hard-coded compilation order matching the batch file if not available

### AERMAP Formula Fixes
1. Examined the original batch file (`gfortran-aermap-64bit.bat`) to identify the correct compilation order.
2. Found that `mod_main1.f` must be compiled first, followed by `mod_tifftags.f`.
3. Updated both formulas (`aermap.rb` and `aermap@24142.rb`) to ensure:
   - Better parsing of the batch file if available
   - A hard-coded compilation order matching the batch file if not available
   - Fixed an issue with file extension handling (.f vs .f90)

### AERMOD Compilation Order
The correct compilation order for AERMOD from `gfortran-aermod.bat`:
1. `modules.f` must be compiled first
2. `grsm.f` must be compiled second
3. Followed by the rest of the source files in the specified order

## Testing
Three test scripts were created to verify the compilation process:
1. `test_aermet_compilation.sh` - Tests AERMET compilation with the correct order
2. `test_aermap_compilation.sh` - Tests AERMAP compilation with the correct order
3. `test_aermod_compilation.sh` - Tests AERMOD compilation with the correct order

These scripts:
- Download the source code
- Create a compilation script with the correct order
- Compile the code
- Test the resulting executable

## Notes for Future Maintenance
1. When updating to new versions, check if the batch files have changed.
2. Pay attention to the compilation order in the batch files, especially for module files.
3. Always ensure that modules are compiled in the correct order of dependencies.
4. The key principle is that in Fortran, a module must be compiled before any file that uses it.

## Next Steps
1. Run the test scripts to verify the fixes.
2. Consider implementing automated testing of compilation in the CI/CD pipeline.
3. Consider adding more detailed error checking and reporting in the formula.
