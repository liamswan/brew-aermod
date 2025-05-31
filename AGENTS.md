# Brew-AERMOD Agent Guide

## Offline Operation

## Repository Overview
This repository contains Homebrew formulas for EPA air dispersion modeling software (AERMOD, AERMET, AERMAP) and supporting scripts for maintenance and testing.

## Repository Structure
- **Formula/**: Contains Homebrew formula definitions
  - Main formulas (`aermod.rb`, `aermet.rb`, `aermap.rb`)
  - Versioned formulas (`aermod@24142.rb`, `aermet@24142.rb`, `aermap@24142.rb`)
  - Meta-package (`aermod-suite.rb`) that depends on all components
- **scripts/**: Utility scripts for maintaining formulas
  - `test_and_audit_formulas.sh`: Tests and audits all formulas
  - `fetch_latest_*.sh`: Scripts to fetch the latest versions
  - `update_readme_versions.sh`: Updates version numbers in README
- **downloads/**: Contains downloaded source files for EPA models
- **checksums/**: SHA256 checksums for downloaded files


## Development Guidelines

### Formula Maintenance
1. Formulas should follow Homebrew's style guide
2. Formula structure should have elements in the correct order:
   - `desc`, `homepage`, `license`, `url`, `version`, `sha256`
3. Avoid trailing whitespace in formula files
4. Use Ruby best practices as indicated by `brew style` checks

### Testing Instructions
1. **Basic Testing**: Run the test script with default settings:
   ```bash
   ./scripts/test_and_audit_formulas.sh
   ```

2. **Complete Testing with Installation**: To fully test formulas (requires installation):
   ```bash
   ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh
   ```

3. **Individual Formula Tests**: Test a specific formula:
   ```bash
   brew test Formula/aermod.rb
   ```

4. **Style Checking**: Check formula style:
   ```bash
   brew style --formula aermod
   ```

5. **Automated Fixes**: Apply automated style fixes:
   ```bash
   brew style --fix aermod
   ```

### Updating Formulas

*Note: Offline mode requires pre-fetched sources. Use fetch scripts before entering offline mode to update the `downloads/` directory with the latest source files.*

1. Check for new versions using the fetch scripts:
   ```bash
   ./scripts/fetch_latest_aermod.sh
   ```

2. Update formula versions and URLs as needed
3. Run the full test suite to verify changes
4. Update README and other documentation with new version information:
   ```bash
   ./scripts/update_readme_versions.sh
   ```

## Agent Work Instructions

### When Exploring the Codebase
1. Focus on the formula files in the `Formula/` directory first
2. Check the test scripts in `scripts/` directory for testing procedures
3. Refer to the audit report (`formula_audit_report.md`) for known issues

### When Making Changes
1. Prioritize fixing common issues identified in audit reports
2. Make changes that maintain compatibility with Homebrew's requirements
3. Always verify changes with appropriate tests
4. Update documentation when changing formula interfaces

### When Reviewing Code
1. Check for Homebrew style compliance
2. Verify that formula structure follows Homebrew conventions
3. Ensure all tests pass, especially with `ALLOW_INSTALL=true`
4. Look for common issues like:
   - Incorrect element ordering in formulas
   - Trailing whitespace
   - Ruby style violations
   - Incomplete test blocks

## Contribution Workflow
1. Make changes to formulas or scripts
2. Run full test suite: `./scripts/test_and_audit_formulas.sh`
3. Fix any issues identified in the audit report
4. Check if changes can be automatically fixed with `brew style --fix`
5. Verify installation works: `brew install --build-from-source Formula/aermod.rb`
6. Submit changes with clear commit messages describing the updates
