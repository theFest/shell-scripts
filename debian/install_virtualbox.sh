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

# Function to install VirtualBox
install_virtualbox() {
  local download_url="$1"
  local package_name="virtualbox.deb"

  echo "Downloading VirtualBox..."
  wget "$download_url" -O "$package_name" || error_exit "Failed to download VirtualBox"

  if dpkg -l virtualbox-* | grep "ii" > /dev/null; then
    echo "Uninstalling existing VirtualBox..."
    apt-get remove --purge virtualbox-* -y || error_exit "Failed to remove existing VirtualBox"
  fi

  echo "Installing VirtualBox..."
  dpkg -i "$package_name" || error_exit "Failed to install VirtualBox"
  apt-get install -f -y || error_exit "Failed to resolve dependencies"
  rm "$package_name" || error_exit "Failed to remove temporary files"
}

# Function to uninstall VirtualBox
uninstall_virtualbox() {
  if dpkg -l virtualbox-* | grep "ii" > /dev/null; then
    echo "Uninstalling VirtualBox..."
    apt-get remove --purge virtualbox-* -y || error_exit "Failed to uninstall VirtualBox"
    echo "VirtualBox has been uninstalled."
  else
    echo "VirtualBox is not installed."
  fi
}

# Function to download VirtualBox Guest Additions
download_guest_additions() {
  local version="7.0.10"
  local download_url="https://download.virtualbox.org/virtualbox/$version/VBoxGuestAdditions_$version.iso"
  local destination_folder="/tmp/guest_additions"

  echo "Downloading VirtualBox Guest Additions..."
  mkdir -p "$destination_folder"
  wget "$download_url" -P "$destination_folder" || error_exit "Failed to download Guest Additions"

  echo "VirtualBox Guest Additions downloaded to $destination_folder"
}

# Main menu
while true; do
  echo "Main Menu:"
  echo "1. Install VirtualBox"
  echo "2. Uninstall VirtualBox"
  echo "3. Download VirtualBox Guest Additions"
  echo "4. Exit"
  read -p "Select an option (1/2/3/4): " choice
  case "$choice" in
    1)
      download_url="https://download.virtualbox.org/virtualbox/7.0.10/virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb"
      install_virtualbox "$download_url"
      echo "VirtualBox 7.0.10 has been successfully installed."
      ;;
    2)
      uninstall_virtualbox
      ;;
    3)
      download_guest_additions
      ;;
    4)
      echo "Exiting the script."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
done
