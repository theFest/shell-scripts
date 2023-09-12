#!/bin/bash

# Update system
sudo pacman -Syu

# Install a firewall
sudo pacman -S ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Install intrusion detection system
sudo pacman -S aide
sudo aide --init
sudo nano /etc/aide.conf # configure aide
sudo crontab -e # add line "0 5 * * * /usr/bin/aide --check" for daily check

# Enable SSH key authentication
sudo nano /etc/ssh/sshd_config # set PasswordAuthentication no

# Disable root login via SSH
sudo nano /etc/ssh/sshd_config # set PermitRootLogin no

# Install and configure fail2ban
sudo pacman -S fail2ban
sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
sudo nano /etc/fail2ban/fail2ban.local # configure jail settings
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Enable periodic security upgrades
sudo pacman -S unattended-upgrades
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades # configure upgrades

# Install and configure SELinux or AppArmor
sudo pacman -S selinux
sudo nano /etc/selinux/config # set SELINUX=enforcing

# Keep software up-to-date
sudo pacman -Syu
