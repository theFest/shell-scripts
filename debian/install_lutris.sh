#!/bin/bash

# Function to check if a package is installed
is_package_installed() {
    dpkg -l | grep -q "^ii  $1"
}

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Update the system
echo "Updating the system..."
apt update
apt upgrade -y

# Check if Lutris is already installed
if is_package_installed "lutris"; then
    echo "Lutris is already installed. Reinstalling..."
    apt purge -y lutris
    apt autoremove -y
fi

# Install required dependencies
echo "Installing required dependencies..."
apt install -y software-properties-common

# Add Lutris repository
if ! is_package_installed "lutris"; then
    echo "Adding Lutris repository..."
    add-apt-repository ppa:lutris-team/lutris
    apt update
fi

# Install Lutris
echo "Installing Lutris..."
apt install -y lutris

# Install Wine
echo "Installing Wine..."
if ! is_package_installed "wine64" || ! is_package_installed "wine32"; then
    dpkg --add-architecture i386
    apt update
    apt install -y wine64 wine32
fi

# Install Vulkan support (if available)
echo "Installing Vulkan support..."
apt install -y mesa-vulkan-drivers || echo "Vulkan support not available or already installed."

# Install additional libraries for compatibility (you can customize this)
echo "Installing additional libraries for compatibility..."
# Note: Some packages may not be available in Kali repositories
# Adjust the package names and sources if needed
apt install -y libgnutls30:i386 libgpg-error0:i386 libxml2:i386 libsdl2-2.0-0:i386 || echo "Some libraries may not be available."

# Configure Wine for Lutris
echo "Configuring Wine for Lutris..."
# Check if lutris command is available before attempting to configure Wine
if command -v lutris &> /dev/null; then
    lutris --install-wine
else
    echo "Lutris is not installed or not found. Wine configuration skipped."
fi

# Enable 32-bit architecture (if not already enabled)
if ! dpkg --print-foreign-architectures | grep -q "i386"; then
    dpkg --add-architecture i386
    apt update
fi

# Install 32-bit libraries (optional, but may be needed for some games)
echo "Installing 32-bit libraries (optional)..."
apt install -y libwine:i386

# Finalize and clean up
echo "Installation complete!"
exit 0

# chmod +x install_lutris.sh

# sudo ./install_lutris.sh

