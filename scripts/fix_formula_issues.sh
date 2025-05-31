#!/bin/zsh

# Fix common issues in homebrew formulas

# Fix script location
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
FORMULA_DIR="${ROOT_DIR}/Formula"

echo "🛠️ Fixing formula issues in ${FORMULA_DIR}"

# Function to fix a formula file
fix_formula() {
  local formula=$1
  echo "🔧 Fixing $formula"
  
  # Create a temporary file
  local tmp_file=$(mktemp)
  
  # 1. Add English module for $CHILD_STATUS
  # 2. Fix URL order (put url before version/license)
  # 3. Fix $? to $CHILD_STATUS
  # 4. Change =~ to match?
  # 5. Remove trailing whitespace
  
  # Add require 'English' if not present
  if ! grep -q "require 'English'" "$formula"; then
    echo "require 'English'" > "$tmp_file"
    cat "$formula" >> "$tmp_file"
    cp "$tmp_file" "$formula"
    rm "$tmp_file"
  fi
  
  # Fix URL order
  # This is complex and requires specific Ruby parsing
  # For now, suggest manual fixing
  
  # Replace $? with $CHILD_STATUS
  sed -i '' 's/\$?/$CHILD_STATUS/g' "$formula"
  
  # Replace =~ with match?
  sed -i '' 's/if \(.*\) =~ \(.*\)/if \1.match? \2/g' "$formula"
  sed -i '' 's/elsif \(.*\) =~ \(.*\)/elsif \1.match? \2/g' "$formula"
  
  # Remove trailing whitespace
  sed -i '' 's/[[:space:]]*$//' "$formula"
  
  # Fix simple if !condition to unless condition
  sed -i '' 's/if !\([^=]*\)/unless \1/g' "$formula"
  
  echo "✅ Fixed $formula"
}

# Process all formula files
for formula in "$FORMULA_DIR"/*.rb; do
  fix_formula "$formula"
done

echo "🎉 All formulas fixed! Next steps:"
echo "1. Run 'brew style --fix' for additional automatic fixes"
echo "2. Run './scripts/test_and_audit_formulas.sh' to verify fixes"
echo "3. Address any remaining issues manually"
