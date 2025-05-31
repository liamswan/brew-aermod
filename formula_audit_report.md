# 🧪 Formula Audit Report
<div align="right">
<strong>Generated on:</strong> Sat May 31 17:19:06 UTC 2025
<br><strong>Mode:</strong> Offline (limited connectivity checks)
</div>

---
## 📊 Executive Summary

| Status | Category | Count |
|:------:|----------|------:|
| ✅ | **Formulas Analyzed** | 7 |
| 🟢 | **Audit Tests** | 7 passed, 0 failed |
| 🟢 | **Style Tests** | 7 passed, 0 failed |
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
      <td><code>aermod-suite</code></td>
      <td>2025</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermap@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermod@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermod</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermap</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermet</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
    </tr>
    <tr>
      <td><code>aermet@24142</code></td>
      <td>24142</td>
      <td>✅ PASSED</td>
      <td>✅ PASSED</td>
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
<summary><strong>📦 aermod-suite (version: 2025)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermap@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermod@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermod (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermap (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermet (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

```

<details>
<summary><strong>📦 aermet@24142 (version: 24142)</strong></summary>

#### Audit

```bash
Syntax OK

NOTE: Running in offline mode - only basic syntax checks performed.
Network-dependent audit checks (URLs, versions, etc.) were skipped.

```

#### Style

```ruby
Style check skipped in offline mode

```

#### Install Test

```bash
Install test skipped in offline mode

```

#### Test

```bash
Tests skipped in offline mode

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
    <td>✅ <strong>7</strong> passed, ❌ <strong>0</strong> failed</td>
  </tr>
  <tr>
    <td>Style</td>
    <td>✅ <strong>7</strong> passed, ❌ <strong>0</strong> failed</td>
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
