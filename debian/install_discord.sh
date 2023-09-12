#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Prompt the user to choose between .deb and .tar.gz
echo "Choose the installation package:"
echo "1. .deb (Debian Package)"
echo "2. .tar.gz (Tarball)"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        # Download and install Discord .deb package
        wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
        dpkg -i /tmp/discord.deb
        rm /tmp/discord.deb
        ;;
    2)
        # Download and install Discord .tar.gz package
        wget -O /tmp/discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
        tar -xzf /tmp/discord.tar.gz -C /opt/
        ln -s /opt/Discord/Discord /usr/bin/discord
        rm /tmp/discord.tar.gz
        ;;
    *)
        echo "Invalid choice. Please choose 1 or 2."
        exit 1
        ;;
esac

# Create a desktop file for Discord
echo "[Desktop Entry]
Name=Discord
Exec=/usr/bin/discord
Icon=discord
Type=Application
Categories=Internet;
Terminal=false" > /usr/share/applications/discord.desktop

echo "Discord has been successfully installed and added to the Start menu."

exit 0

# chmod +x install_discord.sh
