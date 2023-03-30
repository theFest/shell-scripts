#!/bin/bash

# Colors for text formatting
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# Function to print header text
print_header() {
    echo -e "${BLUE}${BOLD}$1${RESET}"
}

# Function to fix package conflicts
fix_package_conflicts() {
    print_header "Fix package conflicts"
    sudo pacman -Syyu --noconfirm
    sudo pacman -S --needed --noconfirm pacman-static
    sudo pacman-static -Syyu --noconfirm
    sudo pacman -S --needed --noconfirm pacman
    sudo pacman -Syyu --noconfirm
    echo -e "${GREEN}Package conflicts fixed.${RESET}"
}

# Function to fix sound problems
fix_sound_problems() {
    print_header "Fix sound problems"
    sudo pacman -S --needed --noconfirm alsa-utils
    sudo alsa force-reload
    echo -e "${GREEN}Sound problems fixed.${RESET}"
}

# Function to fix network problems
fix_network_problems() {
    print_header "Fix network problems"
    sudo systemctl restart NetworkManager
    echo -e "${GREEN}Network problems fixed.${RESET}"
}

# Function to fix boot problems
fix_boot_problems() {
    print_header "Fix boot problems"
    sudo pacman -S --needed --noconfirm grub
    sudo grub-install /dev/sda
    sudo update-grub
    echo -e "${GREEN}Boot problems fixed.${RESET}"
}

# Function to fix display problems
fix_display_problems() {
    print_header "Fix display problems"
    sudo mhwd -a pci nonfree 0300
    echo -e "${GREEN}Display problems fixed.${RESET}"
}

# Function to fix system updates
fix_system_updates() {
    print_header "Fix system updates"
    sudo pacman-mirrors -f 5 && sudo pacman -Syyu --noconfirm
    echo -e "${GREEN}System updates fixed.${RESET}"
}

# Function to print the main menu
print_menu() {
    echo ""
    echo -e "${BLUE}${BOLD}====== Manjaro Problem Fixer ======${RESET}"
    echo "1. Fix package conflicts"
    echo "2. Fix sound problems"
    echo "3. Fix network problems"
    echo "4. Fix boot problems"
    echo "5. Fix display problems"
    echo "6. Fix system updates"
    echo "7. Exit"
    echo -e "${BLUE}${BOLD}=================================${RESET}"
}

# Loop to print the menu and execute the selected option
while true; do
    print_menu
    read -p "Select an option: " option
    case $option in
        1) fix_package_conflicts;;
        2) fix_sound_problems;;
        3) fix_network_problems;;
        4) fix_boot_problems;;
        5) fix_display_problems;;
        6) fix_system_updates;;
        7) exit;;
        *) echo -e "${RED}Invalid option. Please try again.${RESET}";;
    esac
done
