#!/bin/bash

# Define styling variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)

# Prompt user for target URL
read -p "Enter the target URL: " target_url

# Start ZAP proxy and open target URL
echo "${bold}Starting ZAP proxy...${normal}"
zap.sh -daemon -config api.disablekey=true -port 8080 >/dev/null 2>&1
sleep 5

echo "${bold}Opening ${target_url}...${normal}"
firefox --new-window $target_url >/dev/null 2>&1
sleep 5

# Perform active scan
echo "${bold}Performing active scan...${normal}"
zap-cli -p 8080 -s active-scan -r -u $target_url >/dev/null 2>&1
sleep 5

# Save report in HTML format
report_path="${target_url//\//-}.html"
echo "${bold}Saving report to ${report_path}...${normal}"
zap-cli -p 8080 -s report -o $report_path -f html >/dev/null 2>&1

# Shut down ZAP proxy
echo "${bold}Shutting down ZAP proxy...${normal}"
zap-cli -p 8080 -s core shutdown >/dev/null 2>&1
sleep 5

echo "${bold}Web application scanning complete.${normal}"

## For Kali, this script automates web application scanning using the OWASP ZAP tool. It prompts the user for the target URL, performs an active scan and then saves the report in HTML format.
