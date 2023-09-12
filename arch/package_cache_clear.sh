#!/bin/bash

# Update the Manjaro mirror list
sudo pacman-mirrors -f && sudo pacman -Syyu

# Clear the package cache
sudo pacman -Scc

# Re-download the package databases
sudo pacman -Syy

# Prompt the user to update the system
read -p "Would you like to update the system now? (y/n): " choice
if [ "$choice" = "y" ]; then
    # Update the system
    sudo pacman -Syyu

    # Prompt the user to clean up orphaned packages
    read -p "Would you like to remove orphaned packages? (y/n): " choice
    if [ "$choice" = "y" ]; then
        # Remove orphaned packages
        sudo pacman -Rs $(pacman -Qtdq)
    fi
fi

# Prompt the user to clean up package cache
read -p "Would you like to clean up the package cache? (y/n): " choice
if [ "$choice" = "y" ]; then

    # Clean up the package cache
    sudo pacman -Sc
fi


# chmod +x manjaro-update.sh
# ./manjaro-update.sh




#####

# Update the Manjaro mirror list:
#sudo pacman-mirrors -f && sudo pacman -Syyu

# Clear the package cache:
#sudo pacman -Scc

# Try updating the system again:
#sudo pacman -Syyu

# Remove the existing package databases:
#sudo rm -r /var/lib/pacman/sync/*

# Re-download the package databases:
#sudo pacman -Syy

# Try updating the system again:
#sudo pacman -Syyu
