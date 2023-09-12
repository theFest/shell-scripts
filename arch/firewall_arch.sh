#!/bin/bash

## With this simple script, we'll install and configure firewall
#*make exec: chmod +x script.sh

# install the Uncomplicated Firewall (ufw) package
sudo pacman -S ufw

# enables the firewall
sudo ufw enable

# default rule for incoming connections to be denied
sudo ufw default deny incoming

# default rule for outgoing connections to be allowed
sudo ufw default allow outgoing 

# allows incoming connections on the SSH port (22)
sudo ufw allow ssh 

# allows incoming connections on port 80 for HTTP traffic
sudo ufw allow 80/tcp

# allows incoming connections on port 443 for HTTPS traffic 
sudo ufw allow 443/tcp 

# allows incoming SSH connections only from the IP range 192.168.1.0 to 192.168.1.255
sudo ufw allow from 192.168.1.0/24 to any port 22 