#!/bin/bash

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt update
    sudo apt install git -y
fi

# Download GitHub Desktop package
echo "Downloading GitHub Desktop..."
wget https://github.com/shiftkey/desktop/releases/download/release-2.8.3-linux1/GitHubDesktop-linux-2.8.3-linux1.deb

# Install GitHub Desktop
echo "Installing GitHub Desktop..."
sudo dpkg -i GitHubDesktop-linux-2.8.3-linux1.deb
sudo apt install -f -y

# Clean up downloaded package
echo "Cleaning up..."
rm GitHubDesktop-linux-2.8.3-linux1.deb

echo "GitHub Desktop has been successfully installed."

# chmod +x install_github_desktop.sh

# sudo ./install_github_desktop.sh
