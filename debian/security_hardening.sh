#!/bin/bash

# Function to display messages with timestamps
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Check if the script is running with root privileges
if [ "$EUID" -ne 0 ]; then
    log "Please run this script with sudo or as the root user."
    exit 1
fi

# Function to update the system
update_system() {
    log "Updating the system..."
    apt update
    apt upgrade -y
}

# Function to enable and configure the firewall (ufw)
configure_firewall() {
    log "Configuring the firewall..."
    apt install ufw -y
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh     # Allow SSH access, change the port if needed
    ufw allow 80/tcp  # Allow HTTP traffic, change the port if needed
    ufw allow 443/tcp # Allow HTTPS traffic, change the port if needed
    ufw enable
}

# Function to disable root login via SSH
disable_root_ssh() {
    log "Disabling root login via SSH..."
    sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    service ssh restart
}

# Function to install and configure fail2ban
configure_fail2ban() {
    log "Installing fail2ban..."
    apt install fail2ban -y
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    systemctl enable fail2ban
    systemctl start fail2ban
}

# Function to set up automatic security updates
configure_auto_updates() {
    log "Setting up automatic security updates..."
    apt install unattended-upgrades -y
    dpkg-reconfigure -plow unattended-upgrades
}

# Function to enable auditd for system auditing
enable_auditd() {
    log "Enabling auditd for system auditing..."
    apt install auditd -y
    systemctl enable auditd
    systemctl start auditd
}

# Function to set secure permissions on sensitive files
secure_permissions() {
    log "Setting secure permissions on sensitive files..."
    chmod 600 /etc/shadow
    chmod 600 /etc/gshadow
    chmod 644 /etc/passwd
    chmod 644 /etc/group
}

# Function to enable AppArmor if available
enable_apparmor() {
    log "Enabling AppArmor..."
    apt install apparmor -y
    systemctl enable apparmor
    systemctl start apparmor
}

# Function to check for unauthorized access
check_unauthorized_access() {
    log "Checking for unauthorized access..."
    who
    w
    last
}

# Function to securely delete sensitive files
secure_delete() {
    log "Securely deleting sensitive files..."
    # Add commands to securely delete sensitive files here
}

# Main menu
echo "===================="
echo " Security Hardening"
echo "===================="
echo "1. Update the system"
echo "2. Configure firewall"
echo "3. Disable root login via SSH"
echo "4. Install and configure fail2ban"
echo "5. Set up automatic security updates"
echo "6. Enable auditd for system auditing"
echo "7. Set secure permissions on sensitive files"
echo "8. Enable AppArmor"
echo "9. Check for unauthorized access"
echo "10. Securely delete sensitive files"
echo "0. Exit"
echo "===================="

# Read user choice
read -r -p "Enter your choice (0-10): " choice

case $choice in
1) update_system ;;
2) configure_firewall ;;
3) disable_root_ssh ;;
4) configure_fail2ban ;;
5) configure_auto_updates ;;
6) enable_auditd ;;
7) secure_permissions ;;
8) enable_apparmor ;;
9) check_unauthorized_access ;;
10) secure_delete ;;
0) log "Exiting the security script." ;;
*) log "Invalid choice. Exiting the security script." ;;
esac
