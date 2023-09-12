#!/bin/bash

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Prompt user for file to hash
read -p "Enter the path to the file to hash: " file_path

# Generate hash
echo "${bold}Generating hash for ${file_path}...${normal}"
hash=$(sha256sum $file_path | cut -d ' ' -f 1)

echo "${bold}Hash generated:${normal} ${green}$hash${normal}"
