# 🧪 Formula Audit Report
<div align="right">
<strong>Generated on:</strong> Sat May 31 19:33:43 SAST 2025
<br><strong>Mode:</strong> Online (full connectivity checks)
</div>

---
## 📊 Executive Summary

| Status | Category | Count |
|:------:|----------|------:|
| ✅ | **Formulas Analyzed** | 7 |
| 🔴 | **Audit Tests** | 3 passed, 4 failed |
| 🔴 | **Style Tests** | 0 passed, 7 failed |
| 🟢 | **Install Tests** | 7 passed, 0 failed |
| 🟢 | **Functional Tests** | 7 passed, 0 failed, 0 skipped |

---

## 📊 Results Overview

### Overall Status by Formula

<table>
  <thead>
    <tr>
      <th>Formula</th>
      <th>Version</th>
      <th colspan="4">Status</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <th>Audit</th>
      <th>Style</th>
      <th>Install</th>
      <th>Test</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>aermod</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermod@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermap</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermet</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermod-suite</code></td>
      <td></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermet@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermap@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
  </tbody>
</table>

## 📊 Common Issues

<details>
<summary><strong>🔍 Most Common Audit Issues</strong></summary>

1. ⚠️ **URL order**: `url` should be put before `version` in formula definitions
2. ⚠️ **Variable references**: Prefer `$CHILD_STATUS` from the stdlib 'English' module over `$?`
3. ⚠️ **Whitespace**: Trailing whitespace detected in many files
4. ⚠️ **Redundant versions**: Version is redundant with version scanned from URL

</details>

<details>
<summary><strong>🔍 Most Common Style Issues</strong></summary>

1. ⚠️ **Trailing whitespace**: Excessive trailing whitespace in files
2. ⚠️ **Regex matching**: Use `match?` instead of `=~` when MatchData is not used
3. ⚠️ **Conditional statements**: Favor `unless` over `if` for negative conditions
4. ⚠️ **Modifier usage**: Favor modifier `if` usage when having a single-line body

</details>

<details>
<summary><strong>🔍 Common Test Issues</strong></summary>

❌ **Installation required**: The error "Testing requires the latest version of formula" indicates that formulas need to be installed before testing.

To run tests with installation, use:


Note: Installing formulas during testing may take longer and will actually install the software on your system.
</details>

## 📊 Detailed Analysis

<details>
<summary><strong>📦 aermod (version: 24142)</strong></summary>

#### Audit

```bash
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 46, col 5: FormulaAudit/Miscellaneous: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 46, col 5: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 46, col 5: Don't need 'FileUtils.' before rm

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:46:5: C: FormulaAudit/Miscellaneous: Don't need 'FileUtils.' before rm
    FileUtils.rm(Dir["*.o", "*.mod"])
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1 file inspected, 1 offense detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermod

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermod
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod_24142.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/65daeef90c2ffebd0d81369814da2c49cda79f0e4bea2da1508e36cc18bf77b0--aermod_24142.zip
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/976f4ac253a82549f6ff074ba1c9552e0b4dd24c7c91366c1014b654af1e5c36--aermod_source.zip
==> Installing aermod from liamswan/brew-aermod
[34m==>[0m [1mNo batch file found, using predefined compilation order[0m
[34m==>[0m [1mCompile order: modules.f, grsm.f, aermod.f, setup.f, coset.f, soset.f, reset[0m
[34m==>[0m [1mCompiling modules.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized modules.f[0m
[34m==>[0m [1mCompiling grsm.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized grsm.f[0m
[34m==>[0m [1mCompiling aermod.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized aermod.f[0m
[34m==>[0m [1mCompiling setup.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized setup.f[0m
[34m==>[0m [1mCompiling coset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized coset.f[0m
[34m==>[0m [1mCompiling soset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized soset.f[0m
[34m==>[0m [1mCompiling reset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized reset.f[0m
[34m==>[0m [1mCompiling meset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized meset.f[0m
[34m==>[0m [1mCompiling ouset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized ouset.f[0m
[34m==>[0m [1mCompiling inpsum.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized inpsum.f[0m
[34m==>[0m [1mCompiling metext.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized metext.f[0m
[34m==>[0m [1mCompiling iblval.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized iblval.f[0m
[34m==>[0m [1mCompiling siggrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized siggrid.f[0m
[34m==>[0m [1mCompiling tempgrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized tempgrid.f[0m
[34m==>[0m [1mCompiling windgrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized windgrid.f[0m
[34m==>[0m [1mCompiling calc1.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized calc1.f[0m
[34m==>[0m [1mCompiling calc2.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized calc2.f[0m
[34m==>[0m [1mCompiling prise.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized prise.f[0m
[34m==>[0m [1mCompiling arise.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized arise.f[0m
[34m==>[0m [1mCompiling prime.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized prime.f[0m
[34m==>[0m [1mCompiling sigmas.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sigmas.f[0m
[34m==>[0m [1mCompiling pitarea.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized pitarea.f[0m
[34m==>[0m [1mCompiling uninam.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized uninam.f[0m
[34m==>[0m [1mCompiling output.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized output.f[0m
[34m==>[0m [1mCompiling evset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized evset.f[0m
[34m==>[0m [1mCompiling evcalc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized evcalc.f[0m
[34m==>[0m [1mCompiling evoutput.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized evoutput.f[0m
[34m==>[0m [1mCompiling rline.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized rline.f[0m
[34m==>[0m [1mCompiling bline.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized bline.f[0m
[34m==>[0m [1mLinking 29 object files: modules.o, grsm.o, aermod.o, setup.o, coset.o, sose[0m
[34m==>[0m [1mgfortran -o aermod -O2 modules.o grsm.o aermod.o setup.o coset.o soset.o res[0m
🍺  /opt/homebrew/Cellar/aermod/24142: 4 files, 2.8MB, built in 44 seconds
==> Running `brew cleanup aermod`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
==> Testing liamswan/brew-aermod/aermod
[34m==>[0m [1m/opt/homebrew/Cellar/aermod/24142/bin/aermod -h 2>&1[0m
Error: liamswan/brew-aermod/aermod: failed
Warning: Removed Sorbet lines from backtrace!
An exception occurred within a child process:
  Minitest::Assertion: Expected: 1
  Actual: 0
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:176:in 'Minitest::Assertions#assert'
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:216:in 'Minitest::Assertions#assert_equal'
/opt/homebrew/Library/Homebrew/formula_assertions.rb:31:in 'Homebrew::Assertions#shell_output'
/opt/homebrew/Library/Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:218:in 'block in <class:Aermod>'
/opt/homebrew/Library/Homebrew/formula.rb:2843:in 'block (3 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/extend/kernel.rb:547:in 'Kernel#with_env'
/opt/homebrew/Library/Homebrew/formula.rb:2842:in 'block (2 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/formula.rb:1192:in 'Formula#with_logging'
/opt/homebrew/Library/Homebrew/formula.rb:2841:in 'block in Formula#run_test'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'block in Mktemp#run'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Dir.chdir'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Mktemp#run'
/opt/homebrew/Library/Homebrew/formula.rb:3181:in 'Formula#mktemp'
/opt/homebrew/Library/Homebrew/formula.rb:2835:in 'Formula#run_test'
/opt/homebrew/Library/Homebrew/test.rb:48:in 'block in <main>'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:185:in 'block in Timeout.timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:38:in 'Timeout::Error.handle_timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:194:in 'Timeout.timeout'
/opt/homebrew/Library/Homebrew/test.rb:54:in '<main>'
Rerun with `--verbose` to see the original backtrace

```

<details>
<summary><strong>📦 aermod@24142 (version: 24142)</strong></summary>

#### Audit

```bash

```

#### Style

```ruby

1 file inspected, no offenses detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermod@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod@24142

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermod@24142
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod_24142.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/65daeef90c2ffebd0d81369814da2c49cda79f0e4bea2da1508e36cc18bf77b0--aermod_24142.zip
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/976f4ac253a82549f6ff074ba1c9552e0b4dd24c7c91366c1014b654af1e5c36--aermod_source.zip
==> Installing aermod@24142 from liamswan/brew-aermod
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized modules.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized grsm.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized aermod.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized setup.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized coset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized soset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized reset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized meset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized ouset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized inpsum.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized metext.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized iblval.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized siggrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized tempgrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized windgrid.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized calc1.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized calc2.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized prise.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized arise.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized prime.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sigmas.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized pitarea.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized uninam.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized output.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized evset.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized evcalc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized evoutput.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized rline.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized bline.f[0m
[34m==>[0m [1mgfortran -o aermod -O2 modules.o grsm.o aermod.o setup.o coset.o soset.o res[0m
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /opt/homebrew
Could not symlink bin/aermod
Target /opt/homebrew/bin/aermod
is a symlink belonging to aermod. You can unlink it:
  brew unlink aermod

To force the link and overwrite all conflicting files:
  brew link --overwrite aermod@24142

To list all files that would be deleted:
  brew link --overwrite aermod@24142 --dry-run

Possible conflicting files are:
/opt/homebrew/bin/aermod -> /opt/homebrew/Cellar/aermod/24142/bin/aermod
==> Summary
🍺  /opt/homebrew/Cellar/aermod@24142/24142: 4 files, 2.8MB, built in 45 seconds
==> Running `brew cleanup aermod@24142`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
Error: liamswan/brew-aermod/aermod@24142 is not linked

```

<details>
<summary><strong>📦 aermap (version: 24142)</strong></summary>

#### Audit

```bash
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 46, col 5: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 46, col 5: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 46, col 5: Don't need 'FileUtils.' before rm

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:46:5: C: Don't need 'FileUtils.' before rm
    FileUtils.rm(Dir["*.o", "*.mod"])
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1 file inspected, 1 offense detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermap

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermap

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermap
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermap_24142.zip
==> Downloading from https://objects.githubusercontent.com/github-production-release-asset-2e65be/993173127/9c0c8610-260f-48bf-a318-ef3668bdf927?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250531%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250531T173611Z&X-Amz-Expires=300&X-Amz-Signature=685e2d14b8e91ffc40fe2fb1c5b7c581e45e8894f49c6e69108609667d4b4fff&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Daermap_24142.zip&response-content-type=application%2Foctet-stream
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip
==> Installing aermap from liamswan/brew-aermod
[34m==>[0m [1mNo batch file found, using predefined compilation order[0m
[34m==>[0m [1mCompile order: mod_main1.f, mod_tifftags.f, aermap.f, sub_calchc.f, sub_chka[0m
[34m==>[0m [1mCompiling mod_main1.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_main1.f[0m
[34m==>[0m [1mCompiling mod_tifftags.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_tifftags.[0m
[34m==>[0m [1mCompiling aermap.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized aermap.f[0m
[34m==>[0m [1mCompiling sub_calchc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_calchc.f[0m
[34m==>[0m [1mCompiling sub_chkadj.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_chkadj.f[0m
[34m==>[0m [1mCompiling sub_chkext.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_chkext.f[0m
[34m==>[0m [1mCompiling sub_demchk.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_demchk.f[0m
[34m==>[0m [1mCompiling sub_nedchk.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_nedchk.f[0m
[34m==>[0m [1mCompiling sub_cnrcnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_cnrcnv.f[0m
[34m==>[0m [1mCompiling sub_demrec.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_demrec.f[0m
[34m==>[0m [1mCompiling sub_demsrc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_demsrc.f[0m
[34m==>[0m [1mCompiling sub_domcnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_domcnv.f[0m
[34m==>[0m [1mCompiling sub_initer_dem.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_initer_de[0m
[34m==>[0m [1mCompiling sub_initer_ned.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_initer_ne[0m
[34m==>[0m [1mCompiling sub_nadcon.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_nadcon.f[0m
[34m==>[0m [1mCompiling sub_reccnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_reccnv.f[0m
[34m==>[0m [1mCompiling sub_recelv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_recelv.f[0m
[34m==>[0m [1mCompiling sub_srccnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_srccnv.f[0m
[34m==>[0m [1mCompiling sub_srcelv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_srcelv.f[0m
[34m==>[0m [1mCompiling sub_utmgeo.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_utmgeo.f[0m
[34m==>[0m [1mCompiling sub_read_tifftags.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized sub_read_tiff[0m
[34m==>[0m [1mLinking 21 object files: mod_main1.o, mod_tifftags.o, aermap.o, sub_calchc.o[0m
[34m==>[0m [1mgfortran -o aermap -O2 mod_main1.o mod_tifftags.o aermap.o sub_calchc.o sub_[0m
🍺  /opt/homebrew/Cellar/aermap/24142: 4 files, 1012.1KB, built in 16 seconds
==> Running `brew cleanup aermap`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
==> Testing liamswan/brew-aermod/aermap
[34m==>[0m [1m/opt/homebrew/Cellar/aermap/24142/bin/aermap -h 2>&1[0m
Error: liamswan/brew-aermod/aermap: failed
Warning: Removed Sorbet lines from backtrace!
An exception occurred within a child process:
  Minitest::Assertion: Expected: 1
  Actual: 0
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:176:in 'Minitest::Assertions#assert'
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:216:in 'Minitest::Assertions#assert_equal'
/opt/homebrew/Library/Homebrew/formula_assertions.rb:31:in 'Homebrew::Assertions#shell_output'
/opt/homebrew/Library/Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:207:in 'block in <class:Aermap>'
/opt/homebrew/Library/Homebrew/formula.rb:2843:in 'block (3 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/extend/kernel.rb:547:in 'Kernel#with_env'
/opt/homebrew/Library/Homebrew/formula.rb:2842:in 'block (2 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/formula.rb:1192:in 'Formula#with_logging'
/opt/homebrew/Library/Homebrew/formula.rb:2841:in 'block in Formula#run_test'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'block in Mktemp#run'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Dir.chdir'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Mktemp#run'
/opt/homebrew/Library/Homebrew/formula.rb:3181:in 'Formula#mktemp'
/opt/homebrew/Library/Homebrew/formula.rb:2835:in 'Formula#run_test'
/opt/homebrew/Library/Homebrew/test.rb:48:in 'block in <main>'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:185:in 'block in Timeout.timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:38:in 'Timeout::Error.handle_timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:194:in 'Timeout.timeout'
/opt/homebrew/Library/Homebrew/test.rb:54:in '<main>'
Rerun with `--verbose` to see the original backtrace

```

<details>
<summary><strong>📦 aermet (version: 24142)</strong></summary>

#### Audit

```bash
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 46, col 5: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 46, col 5: Don't need 'FileUtils.' before rm
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 46, col 5: Don't need 'FileUtils.' before rm

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:46:5: C: Don't need 'FileUtils.' before rm
    FileUtils.rm(Dir["*.o", "*.mod"])
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1 file inspected, 1 offense detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermet

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermet

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermet
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermet_24142.zip
==> Downloading from https://objects.githubusercontent.com/github-production-release-asset-2e65be/993173127/9b449567-e115-433b-81a0-44c96abb317c?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250531%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250531T173655Z&X-Amz-Expires=300&X-Amz-Signature=57a4bfe4600d67f1beb17ca383eb56aa841980d0dd194b3307d9433510c143c8&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Daermet_24142.zip&response-content-type=application%2Foctet-stream
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip
==> Installing aermet from liamswan/brew-aermod
[34m==>[0m [1mNo batch file found, determining module dependencies[0m
[34m==>[0m [1mCompile order: mod_file_units.f90, mod_main1.f90, mod_upperair.f90, mod_surf[0m
[34m==>[0m [1mCompiling mod_file_units.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_file_unit[0m
[34m==>[0m [1mCompiling mod_main1.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_main1.f90[0m
[34m==>[0m [1mCompiling mod_upperair.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_upperair.[0m
[34m==>[0m [1mCompiling mod_surface.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_surface.f[0m
[34m==>[0m [1mCompiling mod_onsite.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_onsite.f9[0m
[34m==>[0m [1mCompiling mod_pbl.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_pbl.f90[0m
[34m==>[0m [1mCompiling mod_read_input.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_read_inpu[0m
[34m==>[0m [1mCompiling mod_reports.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_reports.f[0m
[34m==>[0m [1mCompiling mod_misc.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized mod_misc.f90[0m
[34m==>[0m [1mCompiling aermet.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fno-common -fbounds-check -Wuninitialized aermet.f90[0m
[34m==>[0m [1mLinking 10 object files: mod_file_units.o, mod_main1.o, mod_upperair.o, mod_[0m
[34m==>[0m [1mgfortran -o aermet -O2 mod_file_units.o mod_main1.o mod_upperair.o mod_surfa[0m
🍺  /opt/homebrew/Cellar/aermet/24142: 4 files, 1.7MB, built in 35 seconds
==> Running `brew cleanup aermet`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
==> Testing liamswan/brew-aermod/aermet
[34m==>[0m [1m/opt/homebrew/Cellar/aermet/24142/bin/aermet -h 2>&1[0m
Error: liamswan/brew-aermod/aermet: failed
Warning: Removed Sorbet lines from backtrace!
An exception occurred within a child process:
  Minitest::Assertion: Expected: 1
  Actual: 0
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:176:in 'Minitest::Assertions#assert'
/opt/homebrew/Library/Homebrew/vendor/bundle/ruby/3.4.0/gems/minitest-5.25.5/lib/minitest/assertions.rb:216:in 'Minitest::Assertions#assert_equal'
/opt/homebrew/Library/Homebrew/formula_assertions.rb:31:in 'Homebrew::Assertions#shell_output'
/opt/homebrew/Library/Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:173:in 'block in <class:Aermet>'
/opt/homebrew/Library/Homebrew/formula.rb:2843:in 'block (3 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/extend/kernel.rb:547:in 'Kernel#with_env'
/opt/homebrew/Library/Homebrew/formula.rb:2842:in 'block (2 levels) in Formula#run_test'
/opt/homebrew/Library/Homebrew/formula.rb:1192:in 'Formula#with_logging'
/opt/homebrew/Library/Homebrew/formula.rb:2841:in 'block in Formula#run_test'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'block in Mktemp#run'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Dir.chdir'
/opt/homebrew/Library/Homebrew/mktemp.rb:88:in 'Mktemp#run'
/opt/homebrew/Library/Homebrew/formula.rb:3181:in 'Formula#mktemp'
/opt/homebrew/Library/Homebrew/formula.rb:2835:in 'Formula#run_test'
/opt/homebrew/Library/Homebrew/test.rb:48:in 'block in <main>'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:185:in 'block in Timeout.timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:38:in 'Timeout::Error.handle_timeout'
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/3.4.4/lib/ruby/3.4.0/timeout.rb:194:in 'Timeout.timeout'
/opt/homebrew/Library/Homebrew/test.rb:54:in '<main>'
Rerun with `--verbose` to see the original backtrace

```

<details>
<summary><strong>📦 aermod-suite (version: )</strong></summary>

#### Audit

```bash
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
Error: 1 problem in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
Error: 2 problems in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
  * Stable: The source URL https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz is not reachable (HTTP status code 404)

```

#### Style

```ruby

1 file inspected, no offenses detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermod-suite

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod-suite

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermod-suite
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz
curl: (56) The requested URL returned error: 404
Error: aermod-suite: Failed to download resource "aermod-suite"
Download failed: https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz

⚙️ Running tests...
Error: Testing requires the latest version of liamswan/brew-aermod/aermod-suite

```

<details>
<summary><strong>📦 aermet@24142 (version: 24142)</strong></summary>

#### Audit

```bash

```

#### Style

```ruby

1 file inspected, no offenses detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermet@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermet@24142

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermet@24142
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermet_24142.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/1035d84256ea3c69cc07fad772f5a1e88ce6e0501dc937f70c87baeee66e5797--aermet_24142.zip
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/94ac237220c3ef0fc18d33258e3429dc6f1b87dd3ae850eaacd839127afcde92--aermet_source.zip
==> Installing aermet@24142 from liamswan/brew-aermod
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_file_units.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_main1.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_upperair.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_surface.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_onsite.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_pbl.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_read_input.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_reports.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_misc.f90[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized aermet.f90[0m
[34m==>[0m [1mgfortran -o aermet -O2 mod_file_units.o mod_main1.o mod_upperair.o mod_surfa[0m
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /opt/homebrew
Could not symlink bin/aermet
Target /opt/homebrew/bin/aermet
is a symlink belonging to aermet. You can unlink it:
  brew unlink aermet

To force the link and overwrite all conflicting files:
  brew link --overwrite aermet@24142

To list all files that would be deleted:
  brew link --overwrite aermet@24142 --dry-run

Possible conflicting files are:
/opt/homebrew/bin/aermet -> /opt/homebrew/Cellar/aermet/24142/bin/aermet
==> Summary
🍺  /opt/homebrew/Cellar/aermet@24142/24142: 4 files, 1.7MB, built in 35 seconds
==> Running `brew cleanup aermet@24142`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
Error: liamswan/brew-aermod/aermet@24142 is not linked

```

<details>
<summary><strong>📦 aermap@24142 (version: 24142)</strong></summary>

#### Audit

```bash

```

#### Style

```ruby

1 file inspected, no offenses detected

```

#### Install Test

```bash
==> Would install 1 formula:
aermap@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermap@24142

⚙️ Installing formula for testing...
==> Fetching liamswan/brew-aermod/aermap@24142
==> Downloading https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermap_24142.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/421574c8785c883fc1be0fe0ed3b3b1770f252a134d0873d3364d84752b8fd8c--aermap_24142.zip
==> Downloading https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip
Already downloaded: /Users/liamswanepoel/Library/Caches/Homebrew/downloads/24a5c4b4484e1f2b17fd9b0e1685b6a0913c4a4507abdc64404230cf341c84b1--aermap_source.zip
==> Installing aermap@24142 from liamswan/brew-aermod
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_main1.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized mod_tifftags.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized aermap.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_calchc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_chkadj.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_chkext.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_demchk.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_nedchk.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_cnrcnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_demrec.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_demsrc.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_domcnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_initer_dem.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_initer_ned.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_nadcon.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_reccnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_recelv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_srccnv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_srcelv.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_utmgeo.f[0m
[34m==>[0m [1mgfortran -c -J. -O2 -fbounds-check -Wuninitialized sub_read_tifftags.f[0m
[34m==>[0m [1mgfortran -o aermap -O2 mod_main1.o mod_tifftags.o aermap.o sub_calchc.o sub_[0m
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /opt/homebrew
Could not symlink bin/aermap
Target /opt/homebrew/bin/aermap
is a symlink belonging to aermap. You can unlink it:
  brew unlink aermap

To force the link and overwrite all conflicting files:
  brew link --overwrite aermap@24142

To list all files that would be deleted:
  brew link --overwrite aermap@24142 --dry-run

Possible conflicting files are:
/opt/homebrew/bin/aermap -> /opt/homebrew/Cellar/aermap/24142/bin/aermap
==> Summary
🍺  /opt/homebrew/Cellar/aermap@24142/24142: 4 files, 1008.3KB, built in 15 seconds
==> Running `brew cleanup aermap@24142`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

⚙️ Running tests...
Error: liamswan/brew-aermod/aermap@24142 is not linked

```

</details>

## 📊 Next Steps

1. **Address common style issues** - Most formulas have similar style problems that can be automatically fixed
2. **Fix ordering of elements** - Update formula definitions to follow the correct order (url/version/license)
3. **Enable formula installation for testing** - Run with `ALLOW_INSTALL=true` to enable proper test execution
4. **Add proper test blocks** - Ensure all formulas have proper test blocks defined


## 📊 Statistics

<table>
  <tr>
    <th colspan="2">Summary</th>
  </tr>
  <tr>
    <td>Total formulas</td>
    <td><strong>7</strong></td>
  </tr>
  <tr>
    <td>Audit</td>
    <td>✅ <strong>3</strong> passed, ❌ <strong>4</strong> failed</td>
  </tr>
  <tr>
    <td>Style</td>
    <td>✅ <strong>0</strong> passed, ❌ <strong>7</strong> failed</td>
  </tr>
  <tr>
    <td>Install tests</td>
    <td>✅ <strong>7</strong> passed, ❌ <strong>0</strong> failed</td>
  </tr>
  <tr>
    <td>Tests</td>
    <td>✅ <strong>7</strong> passed, ❌ <strong>0</strong> failed, ⚠️ <strong>0</strong> skipped</td>
  </tr>
</table>

## 📊 Fix Opportunities

<div align="center">
<h3>🛠️ 0 of 0 issues (0%) can be fixed automatically</h3>
</div>

To automatically fix the correctable issues, run:



---

<div align="center">
<strong>Report generated by <code>test_and_audit_formulas.sh</code></strong>
</div>
