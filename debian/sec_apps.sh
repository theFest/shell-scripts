#!/bin/bash

# Define the list of security apps with descriptions and installation commands
declare -A security_apps
security_apps=(
  ["Nmap"]="Nmap is a powerful network scanner used for discovering hosts and services on a network. Installation: sudo apt-get install nmap -y"
  ["Wireshark"]="Wireshark is a network protocol analyzer for inspecting data on a network. Installation: sudo apt-get install wireshark -y"
  ["Metasploit"]="Metasploit is a penetration testing framework used for exploiting vulnerabilities. (Custom Installation Required)"
  ["Aircrack-ng"]="Aircrack-ng is a set of tools for auditing wireless networks' security. Installation: sudo apt-get install aircrack-ng -y"
  ["John the Ripper"]="John the Ripper is a password cracking tool to find weak passwords. Installation: sudo apt-get install john -y"
  ["Burp Suite"]="Burp Suite is a web application security testing tool used for scanning and testing web apps. (Custom Installation Required)"
  ["Hydra"]="Hydra is a password cracking tool that supports various protocols and services. Installation: sudo apt-get install hydra -y"
  ["Snort"]="Snort is an open-source network intrusion detection system (NIDS). Installation: sudo apt-get install snort -y"
  ["OpenVAS"]="OpenVAS is a vulnerability scanner and manager for assessing network security. Installation: sudo apt-get install openvas -y"
  ["Maltego"]="Maltego is a tool for open-source intelligence and forensics. (Custom Installation Required)"
  ["Gufw"]="Gufw is a graphical firewall manager for configuring iptables rules. Installation: sudo apt-get install gufw -y"
  ["Fail2ban"]="Fail2ban is an intrusion prevention system that scans logs and bans suspicious IP addresses. Installation: sudo apt-get install fail2ban -y"
)

# Create a temporary file to store the selected apps
tempfile=$(mktemp)

# Create a log file for installation progress
log_file="security_apps_installation.log"
touch "$log_file"

# Function to display the app selection dialog
show_app_selection() {
  for app in "${!security_apps[@]}"; do
    echo "FALSE" "$app" "${security_apps[$app]}" >> "$tempfile"
  done

  selected_apps=$(zenity --list --checklist \
    --title "Security Apps Installation" \
    --text "Select the security apps to install:" \
    --column "" --column "App" --column "Description" \
    --filename="$tempfile" \
    --separator=" " \
    --width=600 --height=400)

  # Capture the selected apps
  if [ -z "$selected_apps" ]; then
    zenity --info --text "No apps selected for installation."
    exit 0
  fi
}

# Function to install selected apps
install_selected_apps() {
  for app in $selected_apps; do
    echo "Installing $app..." >> "$log_file"
    case $app in
      "Nmap")
        sudo apt-get install nmap -y
        ;;
      "Wireshark")
        sudo apt-get install wireshark -y
        ;;
      "Metasploit")
        # Install Metasploit (customize this)
        # Example: Download the latest Metasploit installer script and execute it
        metasploit_installer_url="https://github.com/rapid7/metasploit-framework/archive/refs/tags/5.1.0.tar.gz"
        metasploit_installer_script="metasploit_installer.sh"
        wget "$metasploit_installer_url" -O "$metasploit_installer_script"
        tar -zxvf "$metasploit_installer_script" -C /opt/
        cd /opt/metasploit-framework-*
        sudo bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework-*/$MSF /usr/local/bin/$MSF; done'
        echo "Installed Metasploit." >> "$log_file"
        ;;
      "Aircrack-ng")
        sudo apt-get install aircrack-ng -y
        ;;
      "John the Ripper")
        sudo apt-get install john -y
        ;;
      "Burp Suite")
        # Install Burp Suite (customize this)
        echo "Custom installation for Burp Suite required." >> "$log_file"
        ;;
      "Hydra")
        sudo apt-get install hydra -y
        ;;
      "Snort")
        sudo apt-get install snort -y
        ;;
      "OpenVAS")
        sudo apt-get install openvas -y
        ;;
      "Maltego")
        # Install Maltego (customize this)
        # Example: Download the latest Maltego installer and follow installation steps
        maltego_installer_url="https://www.paterva.com/malv4/community/Maltego.v4.2.13.13462.deb"
        maltego_installer_package="maltego_installer.deb"
        wget "$maltego_installer_url" -O "$maltego_installer_package"
        sudo dpkg -i "$maltego_installer_package"
        sudo apt-get -f install
        maltego
        echo "Installed Maltego." >> "$log_file"
        ;;
      "Gufw")
        sudo apt-get install gufw -y
        ;;
      "Fail2ban")
        sudo apt-get install fail2ban -y
        ;;
    esac
    echo "Installation of $app complete." >> "$log_file"
  done
}

# Function to display a completion message and installation summary
show_completion_message() {
  installation_summary=$(cat "$log_file")
  zenity --info --title "Installation Complete" --text "Selected security apps have been installed successfully.\n\n$installation_summary"
}

# Main script logic
show_app_selection
install_selected_apps
show_completion_message

# Clean up the temporary file
rm "$tempfile"

exit 0
