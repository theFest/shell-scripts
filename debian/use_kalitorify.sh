#!/bin/bash

# This script provides a menu-driven interface for managing Tor(system-wide) usage through KaliTorify.
# It allows users to perform various actions such as installing KaliTorify, starting a transparent proxy through Tor,
# returning to the clearnet, checking status, showing the public IP address, restarting Tor service, and uninstalling KaliTorify.

# Function to display usage instructions
display_usage() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  1. Install KaliTorify: Installs KaliTorify and necessary dependencies."
    echo "  2. Start transparent proxy through Tor: Initiates a transparent proxy connection through Tor."
    echo "  3. Return to clearnet: Switches back to the regular internet connection from Tor."
    echo "  4. Check status of program and services: Displays the current status of KaliTorify and Tor services."
    echo "  5. Show public IP address: Displays the public IP address as seen through Tor."
    echo "  6. Restart Tor service and change IP address: Restarts the Tor service and obtains a new IP address."
    echo "  7. Uninstall KaliTorify: Removes KaliTorify and associated components."
    echo "  8. Exit: Exits the script."
}

# Install KaliTorify
install_kalitorify() {
    echo "Installing KaliTorify..."
    sudo apt-get update && sudo apt-get dist-upgrade -y
    sudo apt-get install -y tor curl
    git clone https://github.com/brainfucksec/kalitorify
    cd kalitorify || exit
    sudo make install
}

# Start transparent proxy through Tor
start_proxy() {
    echo "Starting transparent proxy through Tor..."
    kalitorify --tor
}

# Return to clearnet
return_to_clearnet() {
    echo "Returning to clearnet..."
    kalitorify --clearnet
}

# Check status of program and services
check_status() {
    echo "Checking status of program and services..."
    kalitorify --status
}

# Show public IP address
show_ip() {
    echo "Showing public IP address..."
    kalitorify --ipinfo
}

# Restart Tor service and change IP address
restart_tor() {
    echo "Restarting Tor service and changing IP address..."
    kalitorify --restart
}

# Uninstall KaliTorify
uninstall_kalitorify() {
    echo "Uninstalling KaliTorify..."
    cd kalitorify || exit
    sudo make uninstall
}

# Main function
main() {
    while true; do
        echo "---------------------------------"
        echo "        KaliTorify Menu          "
        echo "---------------------------------"
        display_usage
        read -rp "Enter your choice [1-8]: " choice
        case $choice in
            1) install_kalitorify ;;
            2) start_proxy ;;
            3) return_to_clearnet ;;
            4) check_status ;;
            5) show_ip ;;
            6) restart_tor ;;
            7) uninstall_kalitorify ;;
            8) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option: $choice. Please enter a valid option." ;;
        esac
    done
}

# Execute main function
main
