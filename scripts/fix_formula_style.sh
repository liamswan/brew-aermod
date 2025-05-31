#!/bin/bash

# Fix style issues in homebrew formulas using brew style --fix

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
FORMULA_DIR="${ROOT_DIR}/Formula"

echo "🛠️ Fixing formula style issues with brew style --fix"

# Fix all formulas
for formula in "$FORMULA_DIR"/*.rb; do
  formula_name=$(basename "$formula" .rb)
  echo "🔧 Fixing $formula_name"
  brew style --fix "$formula_name" || echo "Note: Some issues may require manual fixes"
done

echo "🎉 Applied style fixes! Next steps:"
echo "1. Run './scripts/test_and_audit_formulas.sh' to verify fixes"
echo "2. Address any remaining issues manually"
