#!/bin/bash

# Add the Google Chrome repository key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Add the Google Chrome repository
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update the package lists
sudo pacman -Sy

# Install Google Chrome
sudo pacman -S google-chrome-stable

# chmod +x chrome_install.sh
# ./install-chrome.sh
