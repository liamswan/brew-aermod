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

# Add Homebrew to the shell profile and current environment
if [[ "$OS" == "Darwin" ]]; then
  # macOS
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OS" == "Linux" ]]; then
  # Linux
  # Determine if running as root
  if [[ $EUID -eq 0 ]]; then
    # Running as root
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
    # Also add to current shell environment
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  else
    # Running as regular user
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
  fi
  
  # Apply to current shell session (this is crucial for the script to continue working)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  
  # Install essential dependencies for Linux
  if command -v apt-get >/dev/null 2>&1; then
    echo "Installing essential build dependencies..."
    sudo apt-get update
    sudo apt-get install -y build-essential
  fi
else
  echo "Unsupported operating system: $OS"
  exit 1
fi

# Verify installation and PATH setup
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew installation successful!"
  brew --version
  
  # Verify PATH includes Homebrew
  if [[ ":$PATH:" != *":/home/linuxbrew/.linuxbrew/bin:"* ]] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
    echo "WARNING: Homebrew is installed but not in PATH!"
    echo "Current PATH: $PATH"
    
    # Force add to PATH for this session
    if [[ "$OS" == "Darwin" ]]; then
      export PATH="/opt/homebrew/bin:$PATH"
    else
      export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    fi
    echo "Updated PATH: $PATH"
  fi
  
  # Run basic brew commands to verify functionality
  echo "Testing Homebrew functionality..."
  brew doctor || echo "Brew doctor reported issues, but continuing..."
  
  # If you need specific formulae available offline, download them now
  # For example: brew fetch gcc

  # Verify the brew command works by checking its location
  BREW_PATH=$(which brew)
  echo "Using Homebrew from: $BREW_PATH"
  
  # Test if brew can run a simple command
  if brew --prefix >/dev/null 2>&1; then
    echo "Homebrew is fully functional and ready to use!"
  else
    echo "WARNING: Homebrew installation may not be complete or functional."
    exit 1
  fi
  
  # Prepare for offline use
  echo "Preparing Homebrew for potential offline use..."
  
  # Disable auto-update behavior
  export HOMEBREW_NO_AUTO_UPDATE=1
  echo 'export HOMEBREW_NO_AUTO_UPDATE=1' >> ~/.zshrc
  
  # Disable analytics
  brew analytics off
  
  # Prefetch core dependencies that might be needed
  echo "Downloading core dependencies for offline use..."
  brew fetch --deps gcc gfortran
  
  # Download formula dependencies for our custom formulas
  echo "Downloading dependencies for AERMOD suite formulas..."
  for formula in "${ROOT_DIR:-$(pwd)}/Formula/"*.rb; do
    formula_name=$(basename "$formula" .rb)
    echo "Fetching dependencies for $formula_name..."
    brew fetch --deps --formula "$formula" || echo "Warning: Could not fetch all dependencies for $formula_name"
  done
  
  echo "Homebrew setup complete and prepared for offline use!"
else
  echo "Homebrew installation failed."
  exit 1
fi