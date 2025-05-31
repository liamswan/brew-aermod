# CI/CD Plan for brew-aermod

This repository contains Homebrew formulas for AERMOD, AERMET and AERMAP. The CI
workflow builds each formula on macOS and Linux to ensure the formulas compile
and their test blocks run successfully.

## Workflow Overview

- Trigger on pushes to `main` and on pull requests.
- Run on both `ubuntu-latest` and `macos-latest` runners.
- Steps:
  1. Checkout the repository.
  2. Setup Homebrew if the runner is Linux.
  3. Run `brew audit --strict --online` on all formula files.
  4. Install each formula from source with `brew install --build-from-source`.
  5. Execute the formula's `test do` block using `brew test`.

The workflow is defined in `.github/workflows/ci.yml`.

## Automatic Version Updates

### Version Monitoring

Set up a scheduled GitHub Action to periodically check for new versions of AERMOD, AERMET, and AERMAP:

1. Run a workflow on a schedule (e.g., weekly)
2. Use the fetch scripts with the `--version-only` flag to check the latest versions
3. Compare against the current versions in the formulae

### README Updates

When a new version is detected:

1. Update the formula files to use the new version
2. Use the `update_readme_versions.sh` script to update version information in the README
3. Create a pull request with these changes or commit directly to main if preferred

Example workflow:

```yaml
name: Check for Version Updates

on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday at midnight
  workflow_dispatch:  # Allow manual triggering

jobs:
  check-versions:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Check for new versions
        id: version-check
        run: |
          # Get current versions from formula files
          CURRENT_AERMOD=$(grep -E 'version "[0-9]+"' Formula/aermod.rb | grep -oE '[0-9]+')
          CURRENT_AERMET=$(grep -E 'version "[0-9]+"' Formula/aermet.rb | grep -oE '[0-9]+')
          CURRENT_AERMAP=$(grep -E 'version "[0-9]+"' Formula/aermap.rb | grep -oE '[0-9]+')
          
          # Get latest versions from EPA website
          LATEST_AERMOD=$(./scripts/fetch_latest_aermod.sh --version-only)
          LATEST_AERMET=$(./scripts/fetch_latest_aermet.sh --version-only)
          LATEST_AERMAP=$(./scripts/fetch_latest_aermap.sh --version-only)
          
          # Set outputs
          echo "current_aermod=$CURRENT_AERMOD" >> $GITHUB_OUTPUT
          echo "current_aermet=$CURRENT_AERMET" >> $GITHUB_OUTPUT
          echo "current_aermap=$CURRENT_AERMAP" >> $GITHUB_OUTPUT
          echo "latest_aermod=$LATEST_AERMOD" >> $GITHUB_OUTPUT
          echo "latest_aermet=$LATEST_AERMET" >> $GITHUB_OUTPUT
          echo "latest_aermap=$LATEST_AERMAP" >> $GITHUB_OUTPUT
          
          # Determine if updates are needed
          if [[ "$LATEST_AERMOD" != "$CURRENT_AERMOD" || "$LATEST_AERMET" != "$CURRENT_AERMET" || "$LATEST_AERMAP" != "$CURRENT_AERMAP" ]]; then
            echo "update_needed=true" >> $GITHUB_OUTPUT
          else
            echo "update_needed=false" >> $GITHUB_OUTPUT
          fi
      
      - name: Update README if needed
        if: steps.version-check.outputs.update_needed == 'true'
        run: |
          # Update README with new versions
          ./scripts/update_readme_versions.sh
          
          # Create a PR with the changes
          git config --global user.name "GitHub Actions"
          git config --global user.email "actions@github.com"
          
          git add README.md
          git commit -m "Update README with latest AERMOD suite versions"
          git push
```

This workflow can be extended to also update the formula files when new versions are detected.

