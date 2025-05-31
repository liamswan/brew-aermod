# 🧪 Formula Audit Report
<div align="right">
<strong>Generated on:</strong> Sat May 31 14:18:16 SAST 2025
</div>

---
## 📊 Executive Summary

| Status | Category | Count |
|:------:|----------|------:|
| ✅ | **Formulas Analyzed** | 7 |
| 🔴 | **Audit Tests** | 0 passed, 7 failed |
| 🔴 | **Style Tests** | 0 passed, 7 failed |
| 🟢 | **Install Tests** | 7 passed, 0 failed |
| 🟢 | **Functional Tests** | 0 passed, 0 failed, 7 skipped |

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
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermod@24142</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermap</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermet</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermod-suite</code></td>
      <td>2025</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermet@24142</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
    </tr>
    <tr>
      <td><code>aermap@24142</code></td>
      <td>24142</td>
      <td>❌ <strong>FAILED</strong></td>
      <td>❌ <strong>FAILED</strong></td>
      <td>✅ PASSED</td>
      <td>⚠️ <strong>SKIPPED</strong></td>
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
Error: 38 problems in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 154, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 161, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 174, col 1: Trailing whitespace detected.
  * line 180, col 1: Trailing whitespace detected.
  * line 184, col 1: Trailing whitespace detected.
  * line 186, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 191, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.
  * line 198, col 1: Trailing whitespace detected.
  * line 201, col 1: Trailing whitespace detected.
  * line 204, col 1: Trailing whitespace detected.
  * line 207, col 1: Trailing whitespace detected.
  * line 209, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 212, col 1: Trailing whitespace detected.
Error: 38 problems in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 154, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 161, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 174, col 1: Trailing whitespace detected.
  * line 180, col 1: Trailing whitespace detected.
  * line 184, col 1: Trailing whitespace detected.
  * line 186, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 191, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.
  * line 198, col 1: Trailing whitespace detected.
  * line 201, col 1: Trailing whitespace detected.
  * line 204, col 1: Trailing whitespace detected.
  * line 207, col 1: Trailing whitespace detected.
  * line 209, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 212, col 1: Trailing whitespace detected.
Error: 38 problems in 1 formula detected.
liamswan/brew-aermod/aermod
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 154, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 161, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 174, col 1: Trailing whitespace detected.
  * line 180, col 1: Trailing whitespace detected.
  * line 184, col 1: Trailing whitespace detected.
  * line 186, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 191, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.
  * line 198, col 1: Trailing whitespace detected.
  * line 201, col 1: Trailing whitespace detected.
  * line 204, col 1: Trailing whitespace detected.
  * line 207, col 1: Trailing whitespace detected.
  * line 209, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 212, col 1: Trailing whitespace detected.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:6:3: C: [Correctable] url (line 6) should be put before version (line 5)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:24:7: C: [Correctable] Favor unless over if for negative conditions.
      if !resource_exists?(version_resource) ...
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:40:43: C: [Correctable] Unnecessary spacing detected.
    compile_flags = ["-O2", "-fno-common"]  # Add -fno-common to prevent duplicate symbols
                                          ^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:43:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:45:5: C: Don't need 'FileUtils.' before rm_f
    FileUtils.rm_f Dir["*.o", "*.mod"]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod.rb:45:5: C: [Correctable] Use rm or rm_r instead of rm_rf, rm_f, or rmtree.
    FileUtils.rm_f Dir["*.o", "*.mod"]

<em>Note: Showing first 5 of 38 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermod

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermod@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Error: 11 problems in 1 formula detected.
liamswan/brew-aermod/aermod@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 77, col 1: Trailing whitespace detected.
  * line 81, col 1: Trailing whitespace detected.
  * line 85, col 1: Trailing whitespace detected.
  * line 86, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 89, col 1: Trailing whitespace detected.
  * line 91, col 1: Trailing whitespace detected.
  * line 95, col 1: Trailing whitespace detected.
  * line 97, col 7: Use `next` to skip iteration.
  * line 97, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 11 problems in 1 formula detected.
liamswan/brew-aermod/aermod@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 77, col 1: Trailing whitespace detected.
  * line 81, col 1: Trailing whitespace detected.
  * line 85, col 1: Trailing whitespace detected.
  * line 86, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 89, col 1: Trailing whitespace detected.
  * line 91, col 1: Trailing whitespace detected.
  * line 95, col 1: Trailing whitespace detected.
  * line 97, col 7: Use `next` to skip iteration.
  * line 97, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 11 problems in 1 formula detected.
liamswan/brew-aermod/aermod@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 77, col 1: Trailing whitespace detected.
  * line 81, col 1: Trailing whitespace detected.
  * line 85, col 1: Trailing whitespace detected.
  * line 86, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 89, col 1: Trailing whitespace detected.
  * line 91, col 1: Trailing whitespace detected.
  * line 95, col 1: Trailing whitespace detected.
  * line 97, col 7: Use `next` to skip iteration.
  * line 97, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:6:3: C: [Correctable] url (line 6) should be put before version (line 5)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/preferred/aermod/aermod_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:24:7: C: [Correctable] Favor unless over if for negative conditions.
      if !resource_exists?(version_resource) ...
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:77:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:81:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:85:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:86:5: C: [Correctable] Favor modifier if usage when having a single-line body. Another good alternative is the usage of control flow &&/||.
    if source_files.empty?
    ^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:89:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:91:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermod@24142.rb:95:1: C: [Correctable] Trailing whitespace detected.

<em>Note: Showing first 5 of 11 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermod@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod@24142

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermap (version: 24142)</strong></summary>

#### Audit

```bash
Error: 34 problems in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 142, col 1: Trailing whitespace detected.
  * line 146, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 153, col 1: Trailing whitespace detected.
  * line 156, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 176, col 1: Trailing whitespace detected.
  * line 178, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 183, col 1: Trailing whitespace detected.
  * line 188, col 1: Trailing whitespace detected.
  * line 190, col 1: Trailing whitespace detected.
  * line 193, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.
Error: 34 problems in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 142, col 1: Trailing whitespace detected.
  * line 146, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 153, col 1: Trailing whitespace detected.
  * line 156, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 176, col 1: Trailing whitespace detected.
  * line 178, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 183, col 1: Trailing whitespace detected.
  * line 188, col 1: Trailing whitespace detected.
  * line 190, col 1: Trailing whitespace detected.
  * line 193, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.
Error: 34 problems in 1 formula detected.
liamswan/brew-aermod/aermap
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 89, col 1: Trailing whitespace detected.
  * line 99, col 1: Trailing whitespace detected.
  * line 117, col 1: Trailing whitespace detected.
  * line 142, col 1: Trailing whitespace detected.
  * line 146, col 1: Trailing whitespace detected.
  * line 150, col 1: Trailing whitespace detected.
  * line 153, col 1: Trailing whitespace detected.
  * line 156, col 1: Trailing whitespace detected.
  * line 158, col 1: Trailing whitespace detected.
  * line 164, col 1: Trailing whitespace detected.
  * line 166, col 1: Trailing whitespace detected.
  * line 172, col 1: Trailing whitespace detected.
  * line 176, col 1: Trailing whitespace detected.
  * line 178, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 183, col 1: Trailing whitespace detected.
  * line 188, col 1: Trailing whitespace detected.
  * line 190, col 1: Trailing whitespace detected.
  * line 193, col 1: Trailing whitespace detected.
  * line 196, col 1: Trailing whitespace detected.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:5:3: C: [Correctable] url (line 5) should be put before license (line 4)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:40:43: C: [Correctable] Unnecessary spacing detected.
    compile_flags = ["-O2", "-fno-common"]  # Add -fno-common to prevent duplicate symbols
                                          ^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:43:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:45:5: C: Don't need 'FileUtils.' before rm_f
    FileUtils.rm_f Dir["*.o", "*.mod"]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:45:5: C: [Correctable] Use rm or rm_r instead of rm_rf, rm_f, or rmtree.
    FileUtils.rm_f Dir["*.o", "*.mod"]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:46:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap.rb:49:1: C: [Correctable] Trailing whitespace detected.

<em>Note: Showing first 5 of 34 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermap

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermap

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermet (version: 24142)</strong></summary>

#### Audit

```bash
Error: 39 problems in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 84, col 75: Prefer double-quoted strings unless you need single quotes to avoid extra backslashes for escaping.
  * line 85, col 1: Trailing whitespace detected.
  * line 103, col 1: Trailing whitespace detected.
  * line 105, col 119: Line is too long. [169/118]
  * line 106, col 1: Trailing whitespace detected.
  * line 109, col 1: Trailing whitespace detected.
  * line 112, col 1: Trailing whitespace detected.
  * line 115, col 1: Trailing whitespace detected.
  * line 118, col 1: Trailing whitespace detected.
  * line 120, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 123, col 1: Trailing whitespace detected.
  * line 125, col 1: Trailing whitespace detected.
  * line 131, col 1: Trailing whitespace detected.
  * line 133, col 1: Trailing whitespace detected.
  * line 139, col 1: Trailing whitespace detected.
  * line 143, col 1: Trailing whitespace detected.
  * line 145, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 150, col 1: Trailing whitespace detected.
  * line 155, col 1: Trailing whitespace detected.
  * line 156, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 159, col 1: Trailing whitespace detected.
  * line 162, col 1: Trailing whitespace detected.
  * line 165, col 1: Trailing whitespace detected.
Error: 39 problems in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 84, col 75: Prefer double-quoted strings unless you need single quotes to avoid extra backslashes for escaping.
  * line 85, col 1: Trailing whitespace detected.
  * line 103, col 1: Trailing whitespace detected.
  * line 105, col 119: Line is too long. [169/118]
  * line 106, col 1: Trailing whitespace detected.
  * line 109, col 1: Trailing whitespace detected.
  * line 112, col 1: Trailing whitespace detected.
  * line 115, col 1: Trailing whitespace detected.
  * line 118, col 1: Trailing whitespace detected.
  * line 120, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 123, col 1: Trailing whitespace detected.
  * line 125, col 1: Trailing whitespace detected.
  * line 131, col 1: Trailing whitespace detected.
  * line 133, col 1: Trailing whitespace detected.
  * line 139, col 1: Trailing whitespace detected.
  * line 143, col 1: Trailing whitespace detected.
  * line 145, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 150, col 1: Trailing whitespace detected.
  * line 155, col 1: Trailing whitespace detected.
  * line 156, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 159, col 1: Trailing whitespace detected.
  * line 162, col 1: Trailing whitespace detected.
  * line 165, col 1: Trailing whitespace detected.
Error: 39 problems in 1 formula detected.
liamswan/brew-aermod/aermet
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 40, col 43: Unnecessary spacing detected.
  * line 43, col 1: Trailing whitespace detected.
  * line 45, col 5: Don't need 'FileUtils.' before rm_f
  * line 45, col 5: Use `rm` or `rm_r` instead of `rm_rf`, `rm_f`, or `rmtree`.
  * line 46, col 1: Trailing whitespace detected.
  * line 49, col 1: Trailing whitespace detected.
  * line 52, col 1: Trailing whitespace detected.
  * line 56, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 12: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 66, col 15: Use `match?` instead of `=~` when `MatchData` is not used.
  * line 70, col 1: Trailing whitespace detected.
  * line 75, col 1: Trailing whitespace detected.
  * line 80, col 1: Trailing whitespace detected.
  * line 84, col 75: Prefer double-quoted strings unless you need single quotes to avoid extra backslashes for escaping.
  * line 85, col 1: Trailing whitespace detected.
  * line 103, col 1: Trailing whitespace detected.
  * line 105, col 119: Line is too long. [169/118]
  * line 106, col 1: Trailing whitespace detected.
  * line 109, col 1: Trailing whitespace detected.
  * line 112, col 1: Trailing whitespace detected.
  * line 115, col 1: Trailing whitespace detected.
  * line 118, col 1: Trailing whitespace detected.
  * line 120, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 123, col 1: Trailing whitespace detected.
  * line 125, col 1: Trailing whitespace detected.
  * line 131, col 1: Trailing whitespace detected.
  * line 133, col 1: Trailing whitespace detected.
  * line 139, col 1: Trailing whitespace detected.
  * line 143, col 1: Trailing whitespace detected.
  * line 145, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
  * line 150, col 1: Trailing whitespace detected.
  * line 155, col 1: Trailing whitespace detected.
  * line 156, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 159, col 1: Trailing whitespace detected.
  * line 162, col 1: Trailing whitespace detected.
  * line 165, col 1: Trailing whitespace detected.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:6:3: C: [Correctable] url (line 6) should be put before version (line 5)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:24:7: C: [Correctable] Favor unless over if for negative conditions.
      if !resource_exists?(version_resource) ...
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:40:43: C: [Correctable] Unnecessary spacing detected.
    compile_flags = ["-O2", "-fno-common"]  # Add -fno-common to prevent duplicate symbols
                                          ^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:43:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:45:5: C: Don't need 'FileUtils.' before rm_f
    FileUtils.rm_f Dir["*.o", "*.mod"]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet.rb:45:5: C: [Correctable] Use rm or rm_r instead of rm_rf, rm_f, or rmtree.
    FileUtils.rm_f Dir["*.o", "*.mod"]

<em>Note: Showing first 5 of 39 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermet

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermet

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermod-suite (version: 2025)</strong></summary>

#### Audit

```bash
Error: 2 problems in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
  * line 6, col 3: `version` (line 6) should be put before `license` (line 5)
Error: 2 problems in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
  * line 6, col 3: `version` (line 6) should be put before `license` (line 5)
Error: 3 problems in 1 formula detected.
liamswan/brew-aermod/aermod-suite
  * Stable: version 2025 is redundant with version scanned from URL
  * Stable: The source URL https://github.com/liamswan/brew-aermod/releases/download/v20250530/aermod-suite-2025.tar.gz is not reachable (HTTP status code 404)
  * line 6, col 3: `version` (line 6) should be put before `license` (line 5)

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermod-suite.rb:6:3: C: [Correctable] version (line 6) should be put before license (line 5)
  version "2025"
  ^^^^^^^^^^^^^^

1 file inspected, 1 offense detected, 1 offense autocorrectable

```

#### Install Test

```bash
==> Would install 1 formula:
aermod-suite
==> Would install 3 dependencies for aermod-suite:
aermap aermet aermod

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermod-suite

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermet@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Error: 12 problems in 1 formula detected.
liamswan/brew-aermod/aermet@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 57, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 1: Trailing whitespace detected.
  * line 67, col 1: Trailing whitespace detected.
  * line 68, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 71, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 79, col 7: Use `next` to skip iteration.
  * line 79, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 12 problems in 1 formula detected.
liamswan/brew-aermod/aermet@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 57, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 1: Trailing whitespace detected.
  * line 67, col 1: Trailing whitespace detected.
  * line 68, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 71, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 79, col 7: Use `next` to skip iteration.
  * line 79, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 12 problems in 1 formula detected.
liamswan/brew-aermod/aermet@24142
  * line 6, col 3: `url` (line 6) should be put before `version` (line 5)
  * line 24, col 7: Favor `unless` over `if` for negative conditions.
  * line 57, col 1: Trailing whitespace detected.
  * line 60, col 1: Trailing whitespace detected.
  * line 63, col 1: Trailing whitespace detected.
  * line 67, col 1: Trailing whitespace detected.
  * line 68, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 71, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 79, col 7: Use `next` to skip iteration.
  * line 79, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:6:3: C: [Correctable] url (line 6) should be put before version (line 5)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/met/aermet/aermet_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:24:7: C: [Correctable] Favor unless over if for negative conditions.
      if !resource_exists?(version_resource) ...
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:57:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:60:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:63:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:67:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:68:5: C: [Correctable] Favor modifier if usage when having a single-line body. Another good alternative is the usage of control flow &&/||.
    if source_files.empty?
    ^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:71:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermet@24142.rb:73:1: C: [Correctable] Trailing whitespace detected.

<em>Note: Showing first 5 of 12 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermet@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermet@24142

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

```

<details>
<summary><strong>📦 aermap@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Error: 10 problems in 1 formula detected.
liamswan/brew-aermod/aermap@24142
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 69, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 78, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 81, col 1: Trailing whitespace detected.
  * line 83, col 1: Trailing whitespace detected.
  * line 87, col 1: Trailing whitespace detected.
  * line 89, col 7: Use `next` to skip iteration.
  * line 89, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 10 problems in 1 formula detected.
liamswan/brew-aermod/aermap@24142
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 69, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 78, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 81, col 1: Trailing whitespace detected.
  * line 83, col 1: Trailing whitespace detected.
  * line 87, col 1: Trailing whitespace detected.
  * line 89, col 7: Use `next` to skip iteration.
  * line 89, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.
Error: 10 problems in 1 formula detected.
liamswan/brew-aermod/aermap@24142
  * line 5, col 3: `url` (line 5) should be put before `license` (line 4)
  * line 69, col 1: Trailing whitespace detected.
  * line 73, col 1: Trailing whitespace detected.
  * line 77, col 1: Trailing whitespace detected.
  * line 78, col 5: Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.
  * line 81, col 1: Trailing whitespace detected.
  * line 83, col 1: Trailing whitespace detected.
  * line 87, col 1: Trailing whitespace detected.
  * line 89, col 7: Use `next` to skip iteration.
  * line 89, col 14: Prefer `$CHILD_STATUS` from the stdlib 'English' module (don't forget to require it) over `$?`.

```

#### Style

```ruby
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:5:3: C: [Correctable] url (line 5) should be put before license (line 4)
  url "https://gaftp.epa.gov/Air/aqmg/SCRAM/models/related/aermap/aermap_source.zip"
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:69:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:73:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:77:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:78:5: C: [Correctable] Favor modifier if usage when having a single-line body. Another good alternative is the usage of control flow &&/||.
    if source_files.empty?
    ^^
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:81:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:83:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:87:1: C: [Correctable] Trailing whitespace detected.
Taps/liamswan/homebrew-brew-aermod/Formula/aermap@24142.rb:89:7: C: [Correctable] Use next to skip iteration.
      unless $?.success?
      ^^^^^^^^^^^^^^^^^^

<em>Note: Showing first 5 of 10 style issues</em>

```

#### Install Test

```bash
==> Would install 1 formula:
aermap@24142

```

#### Test

```bash
Error: Testing requires the latest version of liamswan/brew-aermod/aermap@24142

⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false.

To enable formula installation during testing, run with:
ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh

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
    <td>✅ <strong>0</strong> passed, ❌ <strong>7</strong> failed</td>
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
    <td>✅ <strong>0</strong> passed, ❌ <strong>0</strong> failed, ⚠️ <strong>7</strong> skipped</td>
  </tr>
</table>

## 📊 Fix Opportunities

<div align="center">
<h3>🛠️ 141 of 144 issues (97%) can be fixed automatically</h3>
</div>

To automatically fix the correctable issues, run:



---

<div align="center">
<strong>Report generated by <code>test_and_audit_formulas.sh</code></strong>
</div>
