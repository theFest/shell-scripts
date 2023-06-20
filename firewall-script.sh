#!/bin/bash

## Version for Kali. This script sets up a basic firewall using iptables to block incoming traffic by default, allow established connections, and open specific ports as needed. It prompts the user for the ports to open and the default policy.

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Prompt user for ports to open and default policy
read -p "Enter the ports to open (separated by commas): " ports
read -p "Enter the default policy (ACCEPT or DROP): " default_policy

# Set default policy
iptables -P INPUT $default_policy

# Allow established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Open specified ports
IFS=',' read -ra port_list <<<"$ports"
for port in "${port_list[@]}"; do
    iptables -A INPUT -p tcp --dport $port -j ACCEPT
done

echo "${bold}Firewall configured.${normal}"
