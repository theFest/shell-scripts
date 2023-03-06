# nano brave-install.sh

#!/bin/bash
echo "Installing dependencies..."
sudo pacman -S --noconfirm curl gconf libappindicator-gtk3 libnotify nss alsa-lib xdg-utils
echo "Downloading Brave browser package..."
curl -s https://brave-browser-downloads.s3.brave.com/latest/brave-browser-apt-release.pub | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
echo "Installing Brave browser..."
sudo pacman -S --noconfirm brave-browser
echo "Done!"

# chmod +x brave-install.sh
# ./brave-install.sh