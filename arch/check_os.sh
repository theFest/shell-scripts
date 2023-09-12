#!/bin/bash

# Function to check if the command is available
function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if run on Windows or Linux
if [ "$OSTYPE" = "cygwin" ] || [ "$OSTYPE" = "msys" ]; then
    echo "Running on Windows"
    
    # Detect specific Windows versions
    if [ -n "$(command -v ver)" ]; then
        echo "Windows Version: $(ver | grep Version | awk '{print $4}')"
    fi
    
    # Add Windows-specific actions here if needed
elif [ "$OSTYPE" = "linux-gnu" ]; then
    echo "Running on Linux"
    
    # Add Linux-specific actions here if needed

    # Check if it's a Debian-based system (e.g., Ubuntu)
    if command_exists lsb_release; then
        distro=$(lsb_release -si)
        version=$(lsb_release -sr)
        echo "Detected $distro $version"
    fi

    # Check if the script is run with root privileges
    if [ "$(id -u)" -eq 0 ]; then
        echo "Running with root privileges"
    fi

    # Check internet connectivity
    if command_exists ping; then
        if ping -c 1 google.com >/dev/null 2>&1; then
            echo "Internet is accessible"
        else
            echo "No internet connection"
        fi
    fi

    # Display CPU and memory information
    echo "CPU Information:"
    cat /proc/cpuinfo | grep "model name" | head -n 1
    echo "Memory Information:"
    free -h

    # Display disk space information
    df -h

elif [ "$OSTYPE" = "darwin" ]; then
    echo "Running on macOS"
    # Add macOS-specific actions here if needed
else
    echo "Unknown or unsupported operating system"
fi

# Display information about the current user
echo "Current User: $(whoami)"
echo "Home Directory: $HOME"

# Print the current date and time
echo "Current Date and Time: $(date)"
