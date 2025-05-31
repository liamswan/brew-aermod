#!/bin/bash

# Simple Homebrew Installation Script

# Set script timeout and download limits
export HOMEBREW_CURL_RETRIES=2
export HOMEBREW_CURL_CONNECT_TIMEOUT=15
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=120
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Determine script directory to find Formula directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

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

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
  echo "Failed to install Homebrew"
  exit 1
}

# Add Homebrew to the shell profile and current environment
if [[ "$OS" == "Darwin" ]]; then
  # macOS
  if [[ -f ~/.zprofile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  elif [[ -f ~/.bash_profile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
  elif [[ -f ~/.profile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
  fi
  
  # Also add to current shell environment
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "WARNING: Cannot find brew in expected location /opt/homebrew/bin/brew"
  fi
elif [[ "$OS" == "Linux" ]]; then
  # Linux
  LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
  
  # Determine if running as root
  if [[ $EUID -eq 0 ]]; then
    # Running as root
    for profile in /root/.bashrc /root/.bash_profile /root/.profile /root/.zshrc; do
      if [[ -f "$profile" ]]; then
        echo 'eval "$('$LINUX_BREW_PATH' shellenv)"' >> "$profile"
      fi
    done
  else
    # Running as regular user
    for profile in ~/.bashrc ~/.bash_profile ~/.profile ~/.zshrc; do
      if [[ -f "$profile" ]]; then
        echo 'eval "$('$LINUX_BREW_PATH' shellenv)"' >> "$profile"
      fi
    done
  fi
  
  # Apply to current shell session (this is crucial for the script to continue working)
  if [[ -f "$LINUX_BREW_PATH" ]]; then
    eval "$($LINUX_BREW_PATH shellenv)"
  else
    echo "WARNING: Cannot find brew in expected location $LINUX_BREW_PATH"
    # Try to find brew in PATH
    if BREW_PATH=$(which brew 2>/dev/null); then
      echo "Found brew at $BREW_PATH, using it instead"
      eval "$($BREW_PATH shellenv)"
    else
      echo "ERROR: Cannot find brew executable. Installation may have failed."
      exit 1
    fi
  fi
  
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
  BREW_PATH=$(which brew)
  if [[ -z "$BREW_PATH" ]]; then
    echo "WARNING: Homebrew is installed but 'which brew' cannot find it!"
    
    # Force add to PATH for this session
    if [[ "$OS" == "Darwin" ]]; then
      export PATH="/opt/homebrew/bin:$PATH"
    else
      export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    fi
    echo "Updated PATH: $PATH"
    
    # Try again
    BREW_PATH=$(which brew)
    if [[ -z "$BREW_PATH" ]]; then
      echo "ERROR: Still cannot find brew in PATH after correction attempt"
      exit 1
    fi
  fi
  
  # Run basic brew commands to verify functionality
  echo "Testing Homebrew functionality..."
  brew doctor || echo "Brew doctor reported issues, but continuing..."
  
  # Verify the brew command works by checking its location
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
  
  # Add to shell profile if needed
  if [[ -n "$SHELL" ]] && [[ "$SHELL" == *"zsh"* ]]; then
    if [[ -f ~/.zshrc ]]; then
      grep -q "HOMEBREW_NO_AUTO_UPDATE" ~/.zshrc || echo 'export HOMEBREW_NO_AUTO_UPDATE=1' >> ~/.zshrc
    fi
  elif [[ -f ~/.bashrc ]]; then
    grep -q "HOMEBREW_NO_AUTO_UPDATE" ~/.bashrc || echo 'export HOMEBREW_NO_AUTO_UPDATE=1' >> ~/.bashrc
  fi
  
  # Disable analytics
  brew analytics off
  
  # Limit the number of dependencies to download to avoid timeout
  # This is especially important in CI environments
  echo "Downloading essential dependencies for offline use..."
  
  # First, try to install GCC directly - this is the most essential package
  # Use a timeout to prevent hanging
  timeout 300 brew install gcc || echo "Warning: Could not install gcc directly, will try fetching instead"
  
  # If we have limited time, focus on the most important dependencies only
  echo "Fetching critical dependencies..."
  brew fetch --deps gcc || echo "Warning: Could not fetch all core dependencies, but continuing"
  
  # Only try to download formula dependencies if there's likely time remaining
  # and the Formula directory exists
  if [[ -d "${ROOT_DIR}/Formula" ]]; then
    echo "Checking AERMOD suite formulas..."
    
    # Use a counter to limit the number of formulas we process
    MAX_FORMULAS=3
    FORMULA_COUNT=0
    
    # Use find to get all .rb files
    for formula in "${ROOT_DIR}/Formula/"*.rb; do
      if [[ -f "$formula" ]] && [[ "$FORMULA_COUNT" -lt "$MAX_FORMULAS" ]]; then
        formula_name=$(basename "$formula" .rb)
        echo "Fetching dependencies for $formula_name..."
        
        # Use a timeout to prevent hanging
        timeout 60 brew fetch --deps --formula "$formula" || echo "Warning: Could not fetch all dependencies for $formula_name"
        
        # Increment the counter
        ((FORMULA_COUNT++))
      fi
    done
    
    echo "Processed $FORMULA_COUNT formulas"
  else
    echo "No Formula directory found at ${ROOT_DIR}/Formula or skipping to save time"
  fi
  
  echo "Homebrew setup complete and prepared for offline use!"
else
  echo "Homebrew installation failed."
  exit 1
fi