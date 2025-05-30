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

