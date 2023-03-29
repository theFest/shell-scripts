#!/bin/bash

# Download the Zoom package
wget https://zoom.us/client/latest/zoom_x86_64.pkg.tar.xz

# Extract the package
tar -xf zoom_x86_64.pkg.tar.xz

# Install dependencies
sudo pacman -S libxcb libxkbcommon-x11 libxcb-xtest libxcb-xinerama

# Install Zoom
sudo pacman -U zoom_x86_64.pkg.tar.xz

# Clean up the extracted package
#rm -rf zoom_x86_64.pkg.tar.xz

# chmod +x install_zoom.sh

# ./install_zoom.sh
