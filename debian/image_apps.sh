#!/bin/bash

# Function to install an application
install_app() {
    sudo apt-get install -y $1
    if [ $? -eq 0 ]; then
        echo "$1 installed successfully!"
    else
        echo "Error installing $1"
    fi
}

# Function to display the menu
display_menu() {
    clear
    echo "Welcome to the Top 10 Image Apps Installer for Kali Linux"
    echo "-------------------------------------------------------"
    echo "Select the applications you want to install:"
    echo "1. GIMP (GNU Image Manipulation Program)"
    echo "2. Inkscape (Vector Graphics Editor)"
    echo "3. ImageMagick (Image Editing Suite)"
    echo "4. Blender (3D Animation and Rendering)"
    echo "5. Darktable (Photography Workflow Software)"
    echo "6. Krita (Digital Painting)"
    echo "7. Shotwell (Photo Manager)"
    echo "8. Pinta (Drawing and Editing Program)"
    echo "9. RawTherapee (High-Quality Raw Image Processing)"
    echo "10. Hugin (Panorama Photo Stitcher)"
    echo "0. Exit"

    read -p "Enter your choice (0-10): " choice
}

# Main menu loop
while true; do
    display_menu

    case $choice in
        0)
            echo "Goodbye!"
            exit
            ;;
        1)
            install_app "gimp"
            ;;
        2)
            install_app "inkscape"
            ;;
        3)
            install_app "imagemagick"
            ;;
        4)
            install_app "blender"
            ;;
        5)
            install_app "darktable"
            ;;
        6)
            install_app "krita"
            ;;
        7)
            install_app "shotwell"
            ;;
        8)
            install_app "pinta"
            ;;
        9)
            install_app "rawtherapee"
            ;;
        10)
            install_app "hugin"
            ;;
        *)
            echo "Invalid choice. Please enter a number between 0 and 10."
            ;;
    esac

    read -p "Press Enter to continue..."
done
