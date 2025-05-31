# 🧪 Formula Audit Report
<div align="right">
<strong>Generated on:</strong> Sat May 31 19:45:57 SAST 2025
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
| 🔴 | **Functional Tests** | 1 passed, 6 failed, 0 skipped |

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
      <td>❌ <strong>FAILED</strong></td>
    </tr>
    <tr>
      <td><code>aermod@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
    </tr>
    <tr>
      <td><code>aermap</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
    </tr>
    <tr>
      <td><code>aermet</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
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
      <td>❌ <strong>FAILED</strong></td>
    </tr>
    <tr>
      <td><code>aermap@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>❌ <strong>FAILED</strong></td>
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
Warning: liamswan/brew-aermod/aermod 24142 is already installed and up-to-date.
To reinstall 24142, run:
  brew reinstall aermod

```

#### Test

```bash
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
Warning: liamswan/brew-aermod/aermod@24142 24142 is already installed, it's just not linked.
To link this version, run:
  brew link aermod@24142

```

#### Test

```bash
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
Warning: liamswan/brew-aermod/aermap 24142 is already installed and up-to-date.
To reinstall 24142, run:
  brew reinstall aermap

```

#### Test

```bash
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
Warning: liamswan/brew-aermod/aermet 24142 is already installed and up-to-date.
To reinstall 24142, run:
  brew reinstall aermet

```

#### Test

```bash
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
Warning: liamswan/brew-aermod/aermet@24142 24142 is already installed, it's just not linked.
To link this version, run:
  brew link aermet@24142

```

#### Test

```bash
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
Warning: liamswan/brew-aermod/aermap@24142 24142 is already installed, it's just not linked.
To link this version, run:
  brew link aermap@24142

```

#### Test

```bash
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
    <td>✅ <strong>1</strong> passed, ❌ <strong>6</strong> failed, ⚠️ <strong>0</strong> skipped</td>
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
