#!/usr/bin/env bash
# Test script to check Homebrew resource paths

set -euo pipefail

echo "Homebrew cache location: $(brew --cache)"
echo "Homebrew repository location: $(brew --repository)"
echo "Homebrew repository liamswan/brew-aermod: $(brew --repository liamswan/brew-aermod)"

echo "Checking if downloads directory exists at various locations:"
echo "1. Direct path: $(pwd)/downloads"
if [ -d "$(pwd)/downloads" ]; then
  echo "   ✓ Directory exists and contains: $(ls -la $(pwd)/downloads)"
else
  echo "   ✗ Directory doesn't exist"
fi

echo "2. Homebrew cache: $(brew --cache)/liamswan/homebrew-brew-aermod/downloads"
if [ -d "$(brew --cache)/liamswan/homebrew-brew-aermod/downloads" ]; then
  echo "   ✓ Directory exists and contains: $(ls -la $(brew --cache)/liamswan/homebrew-brew-aermod/downloads)"
else
  echo "   ✗ Directory doesn't exist"
fi

echo "3. Homebrew repository: $(brew --repository liamswan/brew-aermod)/downloads"
if [ -d "$(brew --repository liamswan/brew-aermod)/downloads" ]; then
  echo "   ✓ Directory exists and contains: $(ls -la $(brew --repository liamswan/brew-aermod)/downloads)"
else
  echo "   ✗ Directory doesn't exist"
fi

# Check if the current directory is already a git repository
if [ -d ".git" ]; then
  echo "Current directory is already a git repository"
else
  echo "Current directory is not a git repository, initializing..."
  git init
  git config --local user.email "test@example.com"
  git config --local user.name "Test User"
  git add .
  git commit -m "Initial commit"
fi

echo "Setting up symbolic link to test tap..."
HOMEBREW_PREFIX=$(brew --prefix)
TAP_PATH="${HOMEBREW_PREFIX}/Homebrew/Library/Taps/liamswan/homebrew-brew-aermod"

if [ ! -d "${TAP_PATH}" ]; then
  echo "Creating tap directory..."
  mkdir -p "${TAP_PATH}"
  
  echo "Creating symbolic link to the current directory..."
  rm -rf "${TAP_PATH}" 2>/dev/null || true
  ln -sf "$(pwd)" "${TAP_PATH}"
  
  echo "Symbolic link created at ${TAP_PATH} -> $(pwd)"
else
  echo "Tap directory already exists at ${TAP_PATH}"
fi

# Create the homebrew cache directory for this tap
CACHE_PATH="$(brew --cache)/liamswan/homebrew-brew-aermod/downloads"
mkdir -p "${CACHE_PATH}"

# Copy zip files to the cache directory
if [ -d "downloads" ]; then
  echo "Copying download files to Homebrew cache..."
  cp -v downloads/*.zip "${CACHE_PATH}/" 2>/dev/null || echo "No zip files to copy"
fi

echo "Homebrew tap and cache setup complete"
