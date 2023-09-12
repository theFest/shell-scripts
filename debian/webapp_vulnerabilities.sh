#!/bin/bash

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Prompt user for target URL and port
read -p "Enter the target URL: " target_url
read -p "Enter the target port: " target_port

# Perform vulnerability scan using nikto and nmap
echo "${bold}Performing vulnerability scan on ${target_url}:${target_port}...${normal}"
nikto -host $target_url -p $target_port
nmap -p $target_port --script http-vuln* $target_url

echo "${bold}Scan complete.${normal}"

## This script uses the nikto and nmap commands to scan a web application for vulnerabilities. It prompts the user for the target URL and port.
