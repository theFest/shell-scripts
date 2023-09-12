#!/bin/bash

# Driver Management GUI Script for Kali Linux

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Display a menu for driver management options
while true; do
  clear
  echo "Driver Management Menu"
  echo "1. Install NVIDIA Drivers"
  echo "2. Install AMD Drivers"
  echo "3. Install WiFi Drivers"
  echo "4. List Installed Drivers"
  echo "5. Uninstall a Driver"
  echo "6. Exit"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      # Install NVIDIA drivers
      echo "Installing NVIDIA drivers..."
      if ! dpkg -l | grep -q "nvidia-driver"; then
        apt-get update
        apt-get install -y nvidia-driver
        echo "NVIDIA drivers installed successfully."
      else
        echo "NVIDIA drivers are already installed."
      fi
      ;;
    2)
      # Install AMD drivers
      echo "Installing AMD drivers..."
      if ! dpkg -l | grep -q "amdgpu-pro"; then
        apt-get update
        apt-get install -y amdgpu-pro
        echo "AMD drivers installed successfully."
      else
        echo "AMD drivers are already installed."
      fi
      ;;
    3)
      # Install WiFi drivers
      echo "Installing WiFi drivers..."
      if ! dpkg -l | grep -q "firmware-iwlwifi"; then
        apt-get update
        apt-get install -y firmware-iwlwifi
        echo "WiFi drivers installed successfully."
      else
        echo "WiFi drivers are already installed."
      fi
      ;;
    4)
      # List installed drivers
      echo "Listing installed drivers..."
      dpkg -l | grep -E "nvidia-driver|amdgpu-pro|firmware-iwlwifi"
      ;;
    5)
      # Uninstall a Driver
      echo "Enter the name of the driver package to uninstall:"
      read -p "Driver Package Name: " driver_package
      if dpkg -l | grep -q "$driver_package"; then
        apt-get remove --purge -y "$driver_package"
        echo "$driver_package has been uninstalled."
      else
        echo "$driver_package is not installed."
      fi
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac

  read -p "Press Enter to continue..."
done
