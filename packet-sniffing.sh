## Packet Sniffing Script (Kali)

#!/bin/bash

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Define menu options as functions
function sniff_packets() {
    echo "${bold}Sniffing packets...${normal}"
    read -p "Enter network interface (ex: eth0): " interface
    tcpdump -i $interface -nn -s0 -w packets.pcap >/dev/null
    echo "${green}Packet sniffing complete. Output saved to packets.pcap.${normal}"
}

# Define menu options
options=("Sniff Packets" "Exit")

# Loop through menu options
while true; do
    echo "${bold}What would you like to do?${normal}"
    select option in "${options[@]}"; do
        case $option in
        "Sniff Packets") sniff_packets ;;
        "Exit") exit ;;
        *) echo "${red}Invalid option.${normal}" && break ;;
        esac
        break
    done
done
