#!/bin/bash

# Colors for styled output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if running with root privileges
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}This script must be run as root. Exiting.${NC}"
    exit 1
fi

# Install yay package manager
echo -e "${GREEN}Installing yay package manager...${NC}"
sudo pacman -Syu --noconfirm git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install snapd and snapcraft package manager
echo -e "${GREEN}Installing snapd and snapcraft...${NC}"
sudo pacman -S --noconfirm snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install snapcraft --classic

# Install Firefox and Slack
echo -e "${GREEN}Installing Firefox and Slack...${NC}"
sudo snap install firefox
SLACK_VERSION=$(curl -s https://slack.com/intl/en-gb/downloads/linux | grep -oP 'data-version=\K[^"]+')
SLACK_FILE="slack-desktop-$SLACK_VERSION-amd64.deb"
wget -O "$SLACK_FILE" "https://downloads.slack-edge.com/linux_releases/$SLACK_FILE"
sudo dpkg -i "$SLACK_FILE"
rm "$SLACK_FILE"

# Set Firefox as default browser
echo -e "${GREEN}Setting Firefox as default browser...${NC}"
xdg-settings set default-web-browser firefox.desktop

# Output success message
echo -e "${GREEN}Installation complete.${NC}"
