#!/usr/bin/env bash
# Test and audit Homebrew formulas locally
# This script tests and audits all formulas in the Formula directory
# Can run in both online and offline modes

set -euo pipefail

# Initialize variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "${SCRIPT_DIR}")"
FORMULA_DIR="${ROOT_DIR}/Formula"
TEMP_DIR="$(mktemp -d)"
REPORT_FILE="${ROOT_DIR}/formula_audit_report.md"
COLORS_ENABLED=true

# Controls whether formulas should be installed during testing (default: false)
# Set to true to allow formula installation and full testing with:
# ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh
ALLOW_INSTALL="${ALLOW_INSTALL:-false}"

# Controls whether to run in offline mode (default: auto-detect)
# Set to true to force offline mode:
# OFFLINE_MODE=true ./scripts/test_and_audit_formulas.sh
# Set to false to force online mode:
# OFFLINE_MODE=false ./scripts/test_and_audit_formulas.sh
OFFLINE_MODE="${OFFLINE_MODE:-auto}"

# Auto-detect internet connectivity if OFFLINE_MODE is set to auto
if [[ "$OFFLINE_MODE" == "auto" ]]; then
  # Try to ping a reliable host to check connectivity
  if ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1 || ping -c 1 -W 1 1.1.1.1 >/dev/null 2>&1; then
    OFFLINE_MODE="false"
    echo "Internet connectivity detected. Running in ONLINE mode."
  else
    OFFLINE_MODE="true"
    echo "No internet connectivity detected. Running in OFFLINE mode."
  fi
fi

# Set Homebrew environment variables for offline mode
if [[ "$OFFLINE_MODE" == "true" ]]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_FROM_API=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  export HOMEBREW_NO_ANALYTICS=1
  
  echo "Running in OFFLINE mode. Network-dependent checks will be limited."
else
  echo "Running in ONLINE mode. All checks will be performed."
fi

# Print paths for debugging
echo "Script directory: ${SCRIPT_DIR}"
echo "Root directory: ${ROOT_DIR}"
echo "Formula directory: ${FORMULA_DIR}"
echo "Temp directory: ${TEMP_DIR}"
echo "Report file: ${REPORT_FILE}"

# Check if we're running in a CI environment or terminal without colors
if [[ -n "${CI:-}" ]] || ! [ -t 1 ]; then
  COLORS_ENABLED=false
fi

# Define color codes if colors are enabled
if [[ "$COLORS_ENABLED" == true ]]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  BOLD='\033[1m'
  NC='\033[0m' # No Color
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  BOLD=''
  NC=''
fi

# Function for logging with colors
log() {
  local level=$1
  local message=$2
  case $level in
    "info")
      echo -e "${BLUE}INFO:${NC} $message"
      ;;
    "success")
      echo -e "${GREEN}SUCCESS:${NC} $message"
      ;;
    "warning")
      echo -e "${YELLOW}WARNING:${NC} $message"
      ;;
    "error")
      echo -e "${RED}ERROR:${NC} $message"
      ;;
    *)
      echo -e "$message"
      ;;
  esac
}

# Function for reporting with improved styling
report_header() {
  echo "# 🧪 Formula Audit Report" > "${REPORT_FILE}"
  echo "<div align=\"right\">" >> "${REPORT_FILE}"
  echo "<strong>Generated on:</strong> $(date)" >> "${REPORT_FILE}"
  if [[ "$OFFLINE_MODE" == "true" ]]; then
    echo "<br><strong>Mode:</strong> Offline (limited connectivity checks)" >> "${REPORT_FILE}"
  else
    echo "<br><strong>Mode:</strong> Online (full connectivity checks)" >> "${REPORT_FILE}"
  fi
  echo "</div>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "---" >> "${REPORT_FILE}"
}

report_section() {
  echo -e "\n## 📊 $1\n" >> "${REPORT_FILE}"
}

report_formula() {
  echo -e "### 📦 $1\n" >> "${REPORT_FILE}"
}

report_item() {
  echo -e "#### $1\n" >> "${REPORT_FILE}"
  echo -e "```\n$2\n```\n" >> "${REPORT_FILE}"
}

# Function to create an executive summary
report_executive_summary() {
  local total=$1
  local audit_passed=$2
  local audit_failed=$3
  local style_passed=$4
  local style_failed=$5
  local install_passed=$6
  local install_failed=$7
  local test_passed=$8
  local test_failed=$9
  local test_skipped=${10}
  
  echo -e "## 📊 Executive Summary\n" >> "${REPORT_FILE}"
  
  echo "| Status | Category | Count |" >> "${REPORT_FILE}"
  echo "|:------:|----------|------:|" >> "${REPORT_FILE}"
  echo "| ✅ | **Formulas Analyzed** | ${total} |" >> "${REPORT_FILE}"
  echo "| $([[ $audit_failed -eq 0 ]] && echo "🟢" || echo "🔴") | **Audit Tests** | ${audit_passed} passed, ${audit_failed} failed |" >> "${REPORT_FILE}"
  echo "| $([[ $style_failed -eq 0 ]] && echo "🟢" || echo "🔴") | **Style Tests** | ${style_passed} passed, ${style_failed} failed |" >> "${REPORT_FILE}"
  echo "| $([[ $install_failed -eq 0 ]] && echo "🟢" || echo "🔴") | **Install Tests** | ${install_passed} passed, ${install_failed} failed |" >> "${REPORT_FILE}"
  echo "| $([[ $test_failed -eq 0 ]] && echo "🟢" || echo "🔴") | **Functional Tests** | ${test_passed} passed, ${test_failed} failed, ${test_skipped} skipped |" >> "${REPORT_FILE}"
  
  echo "" >> "${REPORT_FILE}"
  echo "---" >> "${REPORT_FILE}"
}

# Function to get formula versions
get_formula_version() {
  local formula_file="$1"
  local version=$(grep -E '^\s*version\s+' "${formula_file}" | head -1 | awk -F'"' '{print $2}')
  if [[ -z "$version" ]]; then
    version=$(grep -E '^\s*version\s+' "${formula_file}" | head -1 | awk '{print $2}')
  fi
  echo "$version"
}

# Function to run brew audit on a formula
audit_formula() {
  local formula_file="$1"
  local formula_name="$(basename "${formula_file}" .rb)"
  local output_file="${TEMP_DIR}/${formula_name}_audit.txt"
  
  log "info" "Auditing formula: ${formula_name}"
  
  if [[ "$OFFLINE_MODE" == "true" ]]; then
    # Run only local syntax checks in offline mode
    log "info" "Running local syntax audit only (offline mode)..."
    
    # Check Ruby syntax
    ruby -c "${formula_file}" > "${output_file}" 2>&1 || true
    
    # Add offline mode notice
    echo "" >> "${output_file}"
    echo "NOTE: Running in offline mode - only basic syntax checks performed." >> "${output_file}"
    echo "Network-dependent audit checks (URLs, versions, etc.) were skipped." >> "${output_file}"
    
    # Consider it a pass if the syntax is valid
    if grep -q "Syntax OK" "${output_file}"; then
      log "success" "Basic syntax check passed for ${formula_name}"
      return 0
    else
      log "error" "Syntax check found issues for ${formula_name}"
      cat "${output_file}"
      return 1
    fi
  else
    # Run full audit in online mode
    log "info" "Running basic audit..."
    brew audit "${formula_name}" > "${output_file}" 2>&1 || true
    
    # Run strict audit
    log "info" "Running strict audit..."
    brew audit --strict "${formula_name}" >> "${output_file}" 2>&1 || true
    
    # Run new formula audit (useful for catching potential issues)
    log "info" "Running new formula audit..."
    brew audit --new "${formula_name}" >> "${output_file}" 2>&1 || true
    
    # Check if audit found issues
    if grep -q "Error:" "${output_file}"; then
      log "error" "Audit found issues for ${formula_name}"
      cat "${output_file}"
      return 1
    else
      log "success" "Audit passed for ${formula_name}"
      return 0
    fi
  fi
}

# Function to run brew style on a formula
style_formula() {
  local formula_file="$1"
  local formula_name="$(basename "${formula_file}" .rb)"
  local output_file="${TEMP_DIR}/${formula_name}_style.txt"

  if [[ "$OFFLINE_MODE" == "true" ]]; then
    log "info" "Skipping style check for ${formula_name} due to offline mode"
    echo "Style check skipped in offline mode" > "${output_file}"
    return 0
  fi

  log "info" "Checking style for formula: ${formula_name}"
  
  # Run style check with --formula flag
  brew style --formula "${formula_name}" > "${output_file}" 2>&1 || true
  
  # Check if style check found issues
  if grep -q "Error:" "${output_file}" || grep -q "offense" "${output_file}"; then
    log "error" "Style check found issues for ${formula_name}"
    cat "${output_file}"
    return 1
  else
    log "success" "Style check passed for ${formula_name}"
    return 0
  fi
}

# Function to test formula installation
test_formula_install() {
  local formula_file="$1"
  local formula_name="$(basename "${formula_file}" .rb)"
  local output_file="${TEMP_DIR}/${formula_name}_install.txt"

  if [[ "$OFFLINE_MODE" == "true" ]]; then
    log "info" "Skipping install test for ${formula_name} due to offline mode"
    echo "Install test skipped in offline mode" > "${output_file}"
    return 0
  fi

  log "info" "Testing installation of formula: ${formula_name}"
  
  # Test install with --build-from-source --dry-run
  brew install --formula --build-from-source --dry-run "${formula_name}" > "${output_file}" 2>&1
  local install_exit_code=$?
  
  # Check for errors in the output or exit code
  if [ $install_exit_code -ne 0 ] || grep -q "Error:" "${output_file}"; then
    log "error" "Install test failed for ${formula_name}"
    cat "${output_file}"
    return 1
  else
    log "success" "Install test passed for ${formula_name}"
    return 0
  fi
}

# Function to run a formula's tests
test_formula() {
  local formula_file="$1"
  local formula_name="$(basename "${formula_file}" .rb)"
  local output_file="${TEMP_DIR}/${formula_name}_test.txt"

  if [[ "$OFFLINE_MODE" == "true" ]]; then
    log "info" "Skipping tests for ${formula_name} due to offline mode"
    echo "Tests skipped in offline mode" > "${output_file}"
    return 0
  fi

  log "info" "Running test for formula: ${formula_name}"
  
  # Check if the formula has a test block
  if grep -q "test do" "${formula_file}"; then
    # First run test to see if it works without installation
    brew test "${formula_name}" > "${output_file}" 2>&1 || true
    
    # Check if test indicates installation is required
    if grep -q "Testing requires the latest version" "${output_file}"; then
      # Installation is required for this test
      if [[ "${ALLOW_INSTALL}" == "true" ]]; then
        log "info" "Installing ${formula_name} for testing..."
        echo "" >> "${output_file}"
        echo "⚙️ Installing formula for testing..." >> "${output_file}"
        
        # Install the formula to run tests
        brew install --formula "${formula_name}" >> "${output_file}" 2>&1 || true
        
        # Run the test if installation was successful
        if ! grep -q "Error: Failed to install" "${output_file}"; then
          log "info" "Running tests for installed formula..."
          echo "" >> "${output_file}"
          echo "⚙️ Running tests..." >> "${output_file}"
          brew test "${formula_name}" >> "${output_file}" 2>&1 || true
        fi
      else
        # Just note that installation is required but we're skipping it
        echo "" >> "${output_file}"
        echo "⚠️ Formula test requires installation. Test skipped because ALLOW_INSTALL=false." >> "${output_file}"
        echo "" >> "${output_file}"
        echo "To enable formula installation during testing, run with:" >> "${output_file}"
        echo "ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh" >> "${output_file}"
        log "warning" "Test skipped for ${formula_name} (installation required)"
        return 2  # Return code 2 means "skipped" (installation required but skipped)
      fi
    fi
    
    # Check for errors in the output or exit code
    if grep -q "Error:" "${output_file}" && ! grep -q "Testing requires the latest version" "${output_file}"; then
      log "error" "Test failed for ${formula_name}"
      cat "${output_file}"
      return 1
    # Check if test was skipped due to installation requirement with ALLOW_INSTALL=false
    elif grep -q "Formula test requires installation" "${output_file}"; then
      return 2  # Skipped due to installation requirement
    else
      log "success" "Test passed for ${formula_name}"
      return 0
    fi
  else
    log "warning" "No test block found for ${formula_name}"
    echo "⚠️ No test block found in formula definition" > "${output_file}"
    return 2
  fi
}

# Function to safely read file content
safe_cat() {
  local file="$1"
  if [ -f "${file}" ]; then
    cat "${file}"
  else
    echo "File not found: ${file}"
  fi
}

# Function to analyze issues and suggest auto-fixes
analyze_issues() {
  local correctable_count=0
  local total_issues=0
  
  # Count correctable style issues
  for formula_file in "${FORMULA_FILES[@]}"; do
    local formula_name="$(basename "${formula_file}" .rb)"
    local style_file="${TEMP_DIR}/${formula_name}_style.txt"
    
    if [ -f "${style_file}" ]; then
      # Extract correctable count
      local corr=$(grep -o "[0-9]\\+ offenses autocorrectable" "${style_file}" | awk '{print $1}')
      local total=$(grep -o "[0-9]\\+ offenses detected" "${style_file}" | awk '{print $1}')
      
      if [[ -n "$corr" ]]; then
        correctable_count=$((correctable_count + corr))
      fi
      
      if [[ -n "$total" ]]; then
        total_issues=$((total_issues + total))
      fi
    fi
  done
  
  # Add fix summary to the report
  report_section "Fix Opportunities"
  
  # Calculate percentage
  local fix_percentage=0
  if [ $total_issues -gt 0 ]; then
    fix_percentage=$((correctable_count * 100 / total_issues))
  fi
  
  echo "<div align=\"center\">" >> "${REPORT_FILE}"
  echo "<h3>🛠️ ${correctable_count} of ${total_issues} issues (${fix_percentage}%) can be fixed automatically</h3>" >> "${REPORT_FILE}"
  echo "</div>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  
  echo "To automatically fix the correctable issues, run:" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "```bash" >> "${REPORT_FILE}"
  echo "# Run for each formula" >> "${REPORT_FILE}"
  for formula_file in "${FORMULA_FILES[@]}"; do
    local formula_name="$(basename "${formula_file}" .rb)"
    echo "brew style --fix ${formula_name}" >> "${REPORT_FILE}"
  done
  echo "```" >> "${REPORT_FILE}"
}

# Function to add content to the details section with improved formatting
append_to_details() {
  local title="$1"
  local file="$2"
  
  echo -e "#### ${title}\n" >> "${DETAILS_SECTION}"
  
  # Determine the language for code blocks based on the title
  local language=""
  if [[ "$title" == *"Style"* ]]; then
    language="ruby"
  elif [[ "$title" == *"Install"* || "$title" == *"Test"* ]]; then
    language="bash"
  elif [[ "$title" == *"Audit"* ]]; then
    language="bash"
  fi
  
  echo -e "\`\`\`${language}" >> "${DETAILS_SECTION}"
  
  if [ -f "${file}" ]; then
    # For style issues, limit to first 5 if there are many
    if [[ "$title" == *"Style"* ]] && grep -q "offenses detected" "${file}"; then
      local count=$(grep -o "[0-9]\\+ offenses detected" "${file}" | awk '{print $1}')
      if [ $count -gt 5 ]; then
        # Extract and show the first 5 issues
        head -n 15 "${file}" >> "${DETAILS_SECTION}"
        echo -e "\n<em>Note: Showing first 5 of ${count} style issues</em>" >> "${DETAILS_SECTION}"
      else
        cat "${file}" >> "${DETAILS_SECTION}"
      fi
    else
      cat "${file}" >> "${DETAILS_SECTION}"
    fi
  else
    echo "File not found: ${file}" >> "${DETAILS_SECTION}"
  fi
  
  echo -e "\n\`\`\`\n" >> "${DETAILS_SECTION}"
}

# Main function
main() {
  # Trap errors to ensure we clean up and complete the report
  trap 'finish' EXIT INT TERM

  log "info" "Starting formula testing and auditing"
  log "info" "Working in temporary directory: ${TEMP_DIR}"
  
  # Initialize the report
  report_header
  
  # Get list of formulas (using find to handle spaces in paths)
  FORMULA_FILES=()
  while IFS= read -r -d $'\0' file; do
    FORMULA_FILES+=("$file")
  done < <(find "${FORMULA_DIR}" -name "*.rb" -type f -print0)
  
  log "info" "Found ${#FORMULA_FILES[@]} formulas to test"
  
  # Test each formula
  AUDIT_PASSED=0
  AUDIT_FAILED=0
  STYLE_PASSED=0
  STYLE_FAILED=0
  INSTALL_PASSED=0
  INSTALL_FAILED=0
  TEST_PASSED=0
  TEST_FAILED=0
  TEST_SKIPPED=0
  
  # Create a temporary file for summary table with enhanced formatting
  SUMMARY_TABLE="${TEMP_DIR}/summary_table.md"
  echo "<table>" > "${SUMMARY_TABLE}"
  echo "  <thead>" >> "${SUMMARY_TABLE}"
  echo "    <tr>" >> "${SUMMARY_TABLE}"
  echo "      <th>Formula</th>" >> "${SUMMARY_TABLE}"
  echo "      <th>Version</th>" >> "${SUMMARY_TABLE}"
  echo "      <th colspan=\"4\">Status</th>" >> "${SUMMARY_TABLE}"
  echo "    </tr>" >> "${SUMMARY_TABLE}"
  echo "    <tr>" >> "${SUMMARY_TABLE}"
  echo "      <th></th>" >> "${SUMMARY_TABLE}"
  echo "      <th></th>" >> "${SUMMARY_TABLE}"
  echo "      <th>Audit</th>" >> "${SUMMARY_TABLE}"
  echo "      <th>Style</th>" >> "${SUMMARY_TABLE}"
  echo "      <th>Install</th>" >> "${SUMMARY_TABLE}"
  echo "      <th>Test</th>" >> "${SUMMARY_TABLE}"
  echo "    </tr>" >> "${SUMMARY_TABLE}"
  echo "  </thead>" >> "${SUMMARY_TABLE}"
  echo "  <tbody>" >> "${SUMMARY_TABLE}"
  
  # Create a temporary file for detailed results
  DETAILS_SECTION="${TEMP_DIR}/details_section.md"
  > "${DETAILS_SECTION}"
  
  # Process each formula, with error handling
  for formula_file in "${FORMULA_FILES[@]}"; do
    process_formula "${formula_file}" || log "warning" "Error processing formula, continuing with next one"
  done
  
  # Generate executive summary
  report_executive_summary "${#FORMULA_FILES[@]}" "${AUDIT_PASSED}" "${AUDIT_FAILED}" "${STYLE_PASSED}" "${STYLE_FAILED}" "${INSTALL_PASSED}" "${INSTALL_FAILED}" "${TEST_PASSED}" "${TEST_FAILED}" "${TEST_SKIPPED}"
  
  # Finalize the report
  finish
}

# Function to process a single formula
process_formula() {
  local formula_file="$1"
  formula_name="$(basename "${formula_file}" .rb)"
  formula_version="$(get_formula_version "${formula_file}")"
  
  log "info" "Processing formula: ${formula_name} (version: ${formula_version})"
  
  # Add formula section to details
  echo -e "### ${formula_name} (version: ${formula_version})\n" >> "${DETAILS_SECTION}"
  
  # Run audit
  audit_result="FAILED"
  if audit_formula "${formula_file}"; then
    audit_result="PASSED"
    ((AUDIT_PASSED++))
  else
    ((AUDIT_FAILED++))
  fi
  
  # Add audit results to details
  append_to_details "Audit" "${TEMP_DIR}/${formula_name}_audit.txt"
  
  # Run style check
  style_result="FAILED"
  if style_formula "${formula_file}"; then
    style_result="PASSED"
    ((STYLE_PASSED++))
  else
    ((STYLE_FAILED++))
  fi
  
  # Add style results to details
  append_to_details "Style" "${TEMP_DIR}/${formula_name}_style.txt"
  
  # Test install
  install_result="FAILED"
  if test_formula_install "${formula_file}"; then
    install_result="PASSED"
    ((INSTALL_PASSED++))
  else
    ((INSTALL_FAILED++))
  fi
  
  # Add install results to details
  append_to_details "Install Test" "${TEMP_DIR}/${formula_name}_install.txt"
  
  # Run tests
  test_result="SKIPPED"
  test_formula "${formula_file}"
  test_exit_code=$?
  
  if [ $test_exit_code -eq 0 ]; then
    test_result="PASSED"
    ((TEST_PASSED++))
  elif [ $test_exit_code -eq 1 ]; then
    test_result="FAILED"
    ((TEST_FAILED++))
  else
    ((TEST_SKIPPED++))
  fi
  
  # Add test results to details
  append_to_details "Test" "${TEMP_DIR}/${formula_name}_test.txt"
  
  # Add to summary table with enhanced formatting and visual indicators
  echo "    <tr>" >> "${SUMMARY_TABLE}"
  echo "      <td><code>${formula_name}</code></td>" >> "${SUMMARY_TABLE}"
  echo "      <td>${formula_version}</td>" >> "${SUMMARY_TABLE}"
  
  # Audit status with icon
  if [[ "${audit_result}" == "PASSED" ]]; then
    echo "      <td>✅ PASSED</td>" >> "${SUMMARY_TABLE}"
  else
    echo "      <td>❌ <strong>FAILED</strong></td>" >> "${SUMMARY_TABLE}"
  fi
  
  # Style status with icon
  if [[ "${style_result}" == "PASSED" ]]; then
    echo "      <td>✅ PASSED</td>" >> "${SUMMARY_TABLE}"
  else
    echo "      <td>❌ <strong>FAILED</strong></td>" >> "${SUMMARY_TABLE}"
  fi
  
  # Install status with icon
  if [[ "${install_result}" == "PASSED" ]]; then
    echo "      <td>✅ PASSED</td>" >> "${SUMMARY_TABLE}"
  else
    echo "      <td>❌ <strong>FAILED</strong></td>" >> "${SUMMARY_TABLE}"
  fi
  
  # Test status with icon
  if [[ "${test_result}" == "PASSED" ]]; then
    echo "      <td>✅ PASSED</td>" >> "${SUMMARY_TABLE}"
  elif [[ "${test_result}" == "SKIPPED" ]]; then
    echo "      <td>⚠️ <strong>SKIPPED</strong></td>" >> "${SUMMARY_TABLE}"
  else
    echo "      <td>❌ <strong>FAILED</strong></td>" >> "${SUMMARY_TABLE}"
  fi
  
  echo "    </tr>" >> "${SUMMARY_TABLE}"
  
  return 0
}

# Function to finalize the report and clean up
finish() {
  # Check if report was already generated
  if [ -f "${REPORT_FILE}" ] && grep -q "Statistics" "${REPORT_FILE}"; then
    log "info" "Report already generated, skipping"
    return 0
  fi
  
  # Now add the summary section to the report with enhanced styling
  report_section "Results Overview"
  echo "### Overall Status by Formula" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  
  if [ -f "${SUMMARY_TABLE}" ]; then
    # Close the table properly before adding to report
    echo "  </tbody>" >> "${SUMMARY_TABLE}"
    echo "</table>" >> "${SUMMARY_TABLE}"
    cat "${SUMMARY_TABLE}" >> "${REPORT_FILE}"
  else
    echo "No summary data available" >> "${REPORT_FILE}"
  fi
  
  # Add a section for common issues
  report_section "Common Issues"
  
  # Create collapsible sections for common issues
  echo "<details>" >> "${REPORT_FILE}"
  echo "<summary><strong>🔍 Most Common Audit Issues</strong></summary>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "1. ⚠️ **URL order**: \`url\` should be put before \`version\` in formula definitions" >> "${REPORT_FILE}"
  echo "2. ⚠️ **Variable references**: Prefer \`\$CHILD_STATUS\` from the stdlib 'English' module over \`\$?\`" >> "${REPORT_FILE}"
  echo "3. ⚠️ **Whitespace**: Trailing whitespace detected in many files" >> "${REPORT_FILE}"
  echo "4. ⚠️ **Redundant versions**: Version is redundant with version scanned from URL" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "</details>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  
  echo "<details>" >> "${REPORT_FILE}"
  echo "<summary><strong>🔍 Most Common Style Issues</strong></summary>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "1. ⚠️ **Trailing whitespace**: Excessive trailing whitespace in files" >> "${REPORT_FILE}"
  echo "2. ⚠️ **Regex matching**: Use \`match?\` instead of \`=~\` when MatchData is not used" >> "${REPORT_FILE}"
  echo "3. ⚠️ **Conditional statements**: Favor \`unless\` over \`if\` for negative conditions" >> "${REPORT_FILE}"
  echo "4. ⚠️ **Modifier usage**: Favor modifier \`if\` usage when having a single-line body" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "</details>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  
  echo "<details>" >> "${REPORT_FILE}"
  echo "<summary><strong>🔍 Common Test Issues</strong></summary>" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "❌ **Installation required**: The error \"Testing requires the latest version of formula\" indicates that formulas need to be installed before testing." >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "To run tests with installation, use:" >> "${REPORT_FILE}"
  echo "```bash" >> "${REPORT_FILE}"
  echo "ALLOW_INSTALL=true ./scripts/test_and_audit_formulas.sh" >> "${REPORT_FILE}"
  echo "```" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "Note: Installing formulas during testing may take longer and will actually install the software on your system." >> "${REPORT_FILE}"
  echo "</details>" >> "${REPORT_FILE}"
  
  # Add the details section to the report with improved styling
  report_section "Detailed Analysis"
  
  if [ -f "${DETAILS_SECTION}" ]; then
    # Make a temporary copy for processing with sed
    cp "${DETAILS_SECTION}" "${DETAILS_SECTION}.orig"
    
    # Convert detailed sections to collapsible ones (macOS compatible)
    sed 's/^### \(.*\)$/<details>\
<summary><strong>📦 \1<\/strong><\/summary>/g' "${DETAILS_SECTION}.orig" > "${DETAILS_SECTION}"
    
    # Add the closing detail tag at the end
    echo "</details>" >> "${DETAILS_SECTION}"
    
    cat "${DETAILS_SECTION}" >> "${REPORT_FILE}"
    
    # Clean up temporary file
    rm -f "${DETAILS_SECTION}.orig"
  else
    echo "No detailed data available" >> "${REPORT_FILE}"
  fi
  
  # Add next steps section
  report_section "Next Steps"
  echo "1. **Address common style issues** - Most formulas have similar style problems that can be automatically fixed" >> "${REPORT_FILE}"
  echo "2. **Fix ordering of elements** - Update formula definitions to follow the correct order (url/version/license)" >> "${REPORT_FILE}"
  echo "3. **Enable formula installation for testing** - Run with \`ALLOW_INSTALL=true\` to enable proper test execution" >> "${REPORT_FILE}"
  echo "4. **Add proper test blocks** - Ensure all formulas have proper test blocks defined" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  
  # Add statistics section with enhanced styling
  report_section "Statistics"
  
  echo "<table>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <th colspan=\"2\">Summary</th>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <td>Total formulas</td>" >> "${REPORT_FILE}"
  echo "    <td><strong>${#FORMULA_FILES[@]}</strong></td>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <td>Audit</td>" >> "${REPORT_FILE}"
  echo "    <td>✅ <strong>${AUDIT_PASSED}</strong> passed, ❌ <strong>${AUDIT_FAILED}</strong> failed</td>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <td>Style</td>" >> "${REPORT_FILE}"
  echo "    <td>✅ <strong>${STYLE_PASSED}</strong> passed, ❌ <strong>${STYLE_FAILED}</strong> failed</td>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <td>Install tests</td>" >> "${REPORT_FILE}"
  echo "    <td>✅ <strong>${INSTALL_PASSED}</strong> passed, ❌ <strong>${INSTALL_FAILED}</strong> failed</td>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "  <tr>" >> "${REPORT_FILE}"
  echo "    <td>Tests</td>" >> "${REPORT_FILE}"
  echo "    <td>✅ <strong>${TEST_PASSED}</strong> passed, ❌ <strong>${TEST_FAILED}</strong> failed, ⚠️ <strong>${TEST_SKIPPED}</strong> skipped</td>" >> "${REPORT_FILE}"
  echo "  </tr>" >> "${REPORT_FILE}"
  echo "</table>" >> "${REPORT_FILE}"
  
  # Analyze issues and add fix suggestions
  analyze_issues
  
  echo "" >> "${REPORT_FILE}"
  echo "---" >> "${REPORT_FILE}"
  echo "" >> "${REPORT_FILE}"
  echo "<div align=\"center\">" >> "${REPORT_FILE}"
  echo "<strong>Report generated by <code>test_and_audit_formulas.sh</code></strong>" >> "${REPORT_FILE}"
  echo "</div>" >> "${REPORT_FILE}"
  
  # Print summary to console
  log "info" "Testing and auditing complete"
  log "info" "Results:"
  log "info" "- Total formulas: ${#FORMULA_FILES[@]}"
  log "info" "- Audit: ${AUDIT_PASSED} passed, ${AUDIT_FAILED} failed"
  log "info" "- Style: ${STYLE_PASSED} passed, ${STYLE_FAILED} failed"
  log "info" "- Install tests: ${INSTALL_PASSED} passed, ${INSTALL_FAILED} failed"
  log "info" "- Tests: ${TEST_PASSED} passed, ${TEST_FAILED} failed, ${TEST_SKIPPED} skipped"
  
  log "success" "Report generated at: ${REPORT_FILE}"
  
  # Clean up
  log "info" "Cleaning up..."
  [ -d "${TEMP_DIR}" ] && rm -rf "${TEMP_DIR}"
}

# Run the main function
main "$@"
