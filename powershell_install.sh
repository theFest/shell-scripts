#!/bin/bash

# Install dependencies
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git binutils

# Clone the PowerShell repository
git clone https://aur.archlinux.org/powershell-bin.git
cd powershell-bin

# Build and install PowerShell using makepkg
makepkg -si --noconfirm

# Clean up
cd ..
rm -rf powershell-bin

# Verify the installation
pwsh --version


# chmod +x powershell-install.sh
# ./powershell-install.sh