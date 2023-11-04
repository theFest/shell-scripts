#!/bin/bash

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run with root privileges. Use 'sudo' or 'su' to proceed."
  exit 1
fi

# Function to install .NET SDK
install_dotnet() {
  version="$1"
  echo "Adding Microsoft package repository for .NET SDK..."
  wget -q https://packages.microsoft.com/config/debian/11/prod.list -O /etc/apt/sources.list.d/microsoft-prod.list

  echo "Downloading and installing Microsoft GPG key..."
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O /etc/apt/trusted.gpg.d/microsoft.gpg

  echo "Updating the package list..."
  apt update

  echo "Installing .NET SDK $version..."
  apt install -y "dotnet-sdk-$version"

  if [ $? -eq 0 ]; then
    echo "Installation of .NET SDK $version completed successfully."
  else
    echo "Installation of .NET SDK $version failed. Please check for errors and try again."
  fi
}

# Function to uninstall .NET SDK
uninstall_dotnet() {
  echo "Uninstalling .NET SDK..."
  apt remove --purge -y dotnet-sdk-6.0 dotnet-sdk-7.0 dotnet-sdk-8.0
  apt autoremove -y

  if [ $? -eq 0 ]; then
    echo "Uninstallation completed successfully."
  else
    echo "Uninstallation failed. Please check for errors and try again."
  fi
}

# Main menu
echo "Welcome to the .NET SDK installation/uninstallation script."
while true; do
  echo "Please select an option:"
  echo "1. Install .NET SDK"
  echo "2. Uninstall .NET SDK"
  echo "3. Exit"
  read -p "Enter your choice (1/2/3): " choice

  case $choice in
    1)
      # Submenu for selecting .NET version to install
      echo "Select the .NET SDK version to install:"
      echo "1. .NET SDK 6.0"
      echo "2. .NET SDK 7.0"
      echo "3. .NET SDK 8.0"
      echo "4. Other version (manual)"
      read -p "Enter your choice (1/2/3/4): " dotnet_choice
      case $dotnet_choice in
        1)
          install_dotnet 6.0
          ;;
        2)
          install_dotnet 7.0
          ;;
        3)
          install_dotnet 8.0
          ;;
        4)
          echo "Please specify the version to install manually."
          # Add custom installation logic here
          ;;
        *)
          echo "Invalid choice. Please enter a valid option."
          ;;
      esac
      ;;
    2)
      uninstall_dotnet
      ;;
    3)
      echo "Exiting script."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac
done

# chmod +x install_dotnet.sh
