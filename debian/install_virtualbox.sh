#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Function to display an error message and exit
error_exit() {
  echo "Error: $1"
  exit 1
}

# Function to install VirtualBox from a specific URL
install_virtualbox() {
  local download_url="$1"
  local package_name="virtualbox.deb"

  echo "Downloading VirtualBox..."
  wget "$download_url" -O "$package_name" || error_exit "Failed to download VirtualBox"
  
  # Check if VirtualBox is already installed
  if dpkg -l | grep -q "virtualbox"; then
    echo "Uninstalling existing VirtualBox..."
    dpkg -r virtualbox || error_exit "Failed to remove existing VirtualBox"
  fi
  
  echo "Installing VirtualBox..."
  dpkg -i "$package_name" || error_exit "Failed to install VirtualBox"
  apt-get install -f || error_exit "Failed to resolve dependencies"
  rm "$package_name" || error_exit "Failed to remove temporary files"
}

# Ask the user for confirmation
read -p "This script will download and install VirtualBox 7.0.10 for Debian. Do you want to continue? (Y/N): " choice
case "$choice" in
  [yY]|[yY][eE][sS])
    download_url="https://download.virtualbox.org/virtualbox/7.0.10/virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb"
    install_virtualbox "$download_url"
    echo "VirtualBox 7.0.10 has been successfully installed."
    
    # Start the VirtualBox service if not already running
    if ! systemctl is-active --quiet virtualbox; then
      systemctl start virtualbox
      echo "VirtualBox service started."
    fi
    ;;
  *)
    echo "Installation canceled."
    ;;
esac


# chmod +x install_virtualbox.sh

# sudo ./install_virtualbox.sh
