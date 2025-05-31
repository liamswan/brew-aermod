#!/bin/bash

# Run brew style --fix on all formulas and then run brew audit to verify fixes

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
FORMULA_DIR="${ROOT_DIR}/Formula"

echo "🔍 Running brew style --fix on all formulas"

# Process all formula files
for formula_file in "$FORMULA_DIR"/*.rb; do
  formula_name=$(basename "$formula_file" .rb)
  echo "🔧 Fixing style for $formula_name"
  brew style --fix "$formula_name"
  
  # Additional fixes for common issues
  echo "🔧 Applying additional fixes for $formula_name"
  
  # Fix 'FileUtils.rm_f' to 'rm'
  sed -i '' 's/FileUtils\.rm_f/rm/g' "$formula_file"
  sed -i '' 's/FileUtils\.rm(/rm(/g' "$formula_file"
  
  # Fix the trailing whitespace (in case brew style missed any)
  sed -i '' 's/[[:space:]]*$//' "$formula_file"
  
  # Verify with brew audit
  echo "🔍 Auditing $formula_name"
  brew audit "$formula_name" || echo "⚠️ Some issues may remain for $formula_name"
  echo "-----------------------------------"
done

echo "🎉 Applied fixes to all formulas!"
echo "Next steps:"
echo "1. Run './scripts/test_and_audit_formulas.sh' to verify all fixes"
echo "2. Address any remaining issues manually"
