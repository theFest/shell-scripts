#!/bin/bash

# Step 1: Update your system
sudo apt update
sudo apt upgrade -y
sudo apt install -y linux-headers-$(uname -r) build-essential dkms

# Step 2: Download the AMDGPU drivers from the provided URL
mkdir ~/amdgpu
cd ~/amdgpu

# Download the AMDGPU driver package
wget https://repo.radeon.com/amdgpu-install/23.20/ubuntu/jammy/amdgpu-install_5.7.50700-1_all.deb

# Step 3: Install the AMDGPU drivers
sudo dpkg -i amdgpu-install_5.7.50700-1_all.deb

# Step 4: Reboot your system
sudo reboot

# chmod +x amd_6500xt.sh

# sudo ./amd_6500xt.sh
