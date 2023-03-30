#!/bin/bash
set -e

# Update package repositories
echo "Updating package repositories..."
sudo pacman -Syyu --noconfirm

# Check if yay is installed and install if necessary
if ! command -v yay &> /dev/null
then
    echo "yay not found. Installing yay..."
    sudo pacman -S yay --noconfirm
fi

# Install TeamViewer from the AUR
echo "Installing TeamViewer from the AUR..."
yay -S teamviewer --noconfirm

echo "TeamViewer installation complete!"


# chmod +x install_teamviewer.sh
# ./install_teamviewer.sh
