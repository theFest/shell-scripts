#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Function to install Synaptic
install_synaptic() {
  apt update
  apt install synaptic -y
}

# Function to uninstall Synaptic
uninstall_synaptic() {
  apt remove synaptic --purge -y
}

# Function to add a desktop launcher icon
add_icon() {
  cat <<EOF > /usr/share/applications/synaptic.desktop
[Desktop Entry]
Name=Synaptic Package Manager
Comment=Install and manage software packages
Exec=synaptic-pkexec
Icon=synaptic
Terminal=false
Type=Application
Categories=System;
EOF
}

# Function to remove the desktop launcher icon
remove_icon() {
  rm -f /usr/share/applications/synaptic.desktop
}

# Main script
if [ "$1" == "install" ]; then
  install_synaptic
  add_icon
  echo "Synaptic Package Manager installed and added to the Start Menu."
elif [ "$1" == "uninstall" ]; then
  uninstall_synaptic
  remove_icon
  echo "Synaptic Package Manager uninstalled and removed from the Start Menu."
else
  echo "Usage: $0 [install|uninstall]"
  exit 1
fi

# chmod +x install_synaptic.sh

# sudo ./install_synaptic.sh install
# sudo ./install_synaptic.sh uninstall

