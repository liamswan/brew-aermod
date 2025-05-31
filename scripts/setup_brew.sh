#!/bin/bash

# Simple Homebrew Installation Script

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

# Define important Homebrew environment variables
HOMEBREW_ENV_VARS=(
  "HOMEBREW_NO_AUTO_UPDATE=1"
  "HOMEBREW_NO_ANALYTICS=1"
  "HOMEBREW_NO_INSTALL_CLEANUP=1"
  "HOMEBREW_CURL_RETRIES=2"
  "HOMEBREW_CURL_CONNECT_TIMEOUT=15"
  "HOMEBREW_NO_INSTALL_FROM_API=1"
  "HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1"
  "HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1"
)

# Add Homebrew to the shell profile and current environment
if [[ "$OS" == "Darwin" ]]; then
  # macOS
  if [[ -f ~/.zprofile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    # Add environment variables to ~/.zshrc for persistence
    if [[ -f ~/.zshrc ]]; then
      for var in "${HOMEBREW_ENV_VARS[@]}"; do
        grep -q "$var" ~/.zshrc || echo "export $var" >> ~/.zshrc
      done
    fi
  elif [[ -f ~/.bash_profile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
    # Add environment variables to ~/.bashrc for persistence
    if [[ -f ~/.bashrc ]]; then
      for var in "${HOMEBREW_ENV_VARS[@]}"; do
        grep -q "$var" ~/.bashrc || echo "export $var" >> ~/.bashrc
      done
    fi
  elif [[ -f ~/.profile ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
    for var in "${HOMEBREW_ENV_VARS[@]}"; do
      grep -q "$var" ~/.profile || echo "export $var" >> ~/.profile
    done
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
        # Add environment variables for persistence
        for var in "${HOMEBREW_ENV_VARS[@]}"; do
          grep -q "$var" "$profile" || echo "export $var" >> "$profile"
        done
      fi
    done
  else
    # Running as regular user
    for profile in ~/.bashrc ~/.bash_profile ~/.profile ~/.zshrc; do
      if [[ -f "$profile" ]]; then
        echo 'eval "$('$LINUX_BREW_PATH' shellenv)"' >> "$profile"
        # Add environment variables for persistence
        for var in "${HOMEBREW_ENV_VARS[@]}"; do
          grep -q "$var" "$profile" || echo "export $var" >> "$profile"
        done
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
  
  # Run a quick check to verify Homebrew functionality
  echo "Testing Homebrew functionality..."
  echo "Using Homebrew from: $BREW_PATH"
  
  # Test if brew can run a simple command
  if brew --prefix >/dev/null 2>&1; then
    echo "Homebrew is fully functional and ready to use!"
  else
    echo "WARNING: Homebrew installation may not be complete or functional."
    exit 1
  fi
  
  # Apply the environment variables in the current session
  for var in "${HOMEBREW_ENV_VARS[@]}"; do
    export "$var"
  done
  
  # Disable analytics
  brew analytics off
  
  # Check for Formula directory but limit downloads
  if [[ -d "${ROOT_DIR}/Formula" ]]; then
    echo "Checking for AERMOD suite formulas..."
    # Only try downloading for one formula to save time
    if FIRST_FORMULA=$(find "${ROOT_DIR}/Formula/" -name "*.rb" | head -n 1); then
      if [[ -f "$FIRST_FORMULA" ]]; then
        formula_name=$(basename "$FIRST_FORMULA" .rb)
        echo "Fetching dependencies for $formula_name only (to save time)..."
        timeout 30 brew fetch --deps --formula "$FIRST_FORMULA" || echo "Warning: Could not fetch all dependencies for $formula_name"
      fi
    fi
  fi
  
  echo "Homebrew setup complete and prepared for use!"
else
  echo "Homebrew installation failed."
  exit 1
fi