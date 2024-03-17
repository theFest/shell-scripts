#!/bin/bash

# This script provides a menu-driven interface for configuring various aspects of a Kali Linux system.
# It allows users to perform actions such as updating and upgrading Kali OS, installing essential tools,
# creating a new standard user, configuring network repositories, setting keyboard layout, enabling SSH,
# configuring Firewall, installing VPN (OpenVPN), GDebi (support for .deb files), Terminal Multiplexer (Tilix), and TOR.

# Function to display usage instructions
display_usage() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  1. Update and upgrade Kali OS"
    echo "  2. Install essential tools"
    echo "  3. Create a new standard user"
    echo "  4. Configure network repositories"
    echo "  5. Set keyboard layout"
    echo "  6. Enable SSH"
    echo "  7. Configure Firewall"
    echo "  8. Install VPN (OpenVPN)"
    echo "  9. Install GDebi (support for .deb files)"
    echo " 10. Install Terminal Multiplexer (Tilix)"
    echo " 11. Install TOR"
    echo " 12. Exit"
}

# Update and upgrade Kali OS
update_upgrade_kali() {
    echo "Updating and upgrading Kali OS..."
    sudo apt update
    sudo apt upgrade -y
}

# Install essential tools
install_essential_tools() {
    echo "Installing essential tools..."
    sudo apt install kali-linux-default -y
}

# Create a new standard user
create_new_user() {
    read -rp "Enter the username for the new standard user: " new_username
    echo "Creating a new standard user: $new_username..."
    sudo adduser "$new_username"
}

# Configure network repositories
configure_network_repositories() {
    echo "Configuring network repositories..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
    sudo echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list
    sudo apt update
}

# Set keyboard layout
set_keyboard_layout() {
    echo "Setting keyboard layout..."
    sudo dpkg-reconfigure keyboard-configuration
}

# Enable SSH
enable_ssh() {
    echo "Enabling SSH..."
    sudo apt install openssh-server -y
    sudo service ssh start
}

# Configure Firewall
configure_firewall() {
    echo "Configuring Firewall..."
    sudo apt install ufw -y
    sudo ufw enable
}

# Install VPN (OpenVPN)
install_vpn() {
    echo "Installing VPN (OpenVPN) Software..."
    sudo apt install openvpn -y
}

# Install GDebi (support for .deb files)
install_gdebi() {
    echo "Installing GDebi (support for .deb files)..."
    sudo apt install gdebi -y
}

# Install Terminal Multiplexer (Tilix)
install_tilix() {
    echo "Installing Terminal Multiplexer (Tilix)..."
    sudo apt install tilix -y
}

# Install TOR
install_tor() {
    echo "Installing TOR..."
    sudo apt install tor -y
}

# Main function
main() {
    while true; do
        echo "---------------------------------"
        echo "      Kali Configuration Menu     "
        echo "---------------------------------"
        display_usage
        read -rp "Enter your choice [1-12]: " choice
        case $choice in
            1) update_upgrade_kali ;;
            2) install_essential_tools ;;
            3) create_new_user ;;
            4) configure_network_repositories ;;
            5) set_keyboard_layout ;;
            6) enable_ssh ;;
            7) configure_firewall ;;
            8) install_vpn ;;
            9) install_gdebi ;;
           10) install_tilix ;;
           11) install_tor ;;
           12) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option: $choice. Please enter a valid option." ;;
        esac
    done
}

# Execute main function
main
