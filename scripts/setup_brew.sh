#!/bin/bash

# Simple Homebrew Installation Script

echo "Starting Homebrew installation..."

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
  brew --version
  exit 0
fi

# Determine the OS
OS="$(uname -s)"

# Install Homebrew
echo "Installing Homebrew for $OS..."

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to the shell profile
if [[ "$OS" == "Darwin" ]]; then
  # macOS
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OS" == "Linux" ]]; then
  # Linux
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  echo "Unsupported operating system: $OS"
  exit 1
fi

# Verify installation
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew installation successful!"
  brew --version
else
  echo "Homebrew installation failed."
  exit 1
fi