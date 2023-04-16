#!/bin/bash

# Install required packages
apt update
apt install -y pip curl htop file build-essential nginx jq certbot python3-certbot-nginx ufw vim git netcat cron unzip atop lshw cifs-utils lsof libusb-1.0-0/focal pkg-config gnupg unzstd tmux aria2 reiserfsprogs lz4 sysstat

# Configure SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Install fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Add new user
sudo adduser subspaceadmin

# Add user to sudo group
sudo usermod -aG sudo subspaceadmin

# Allow incoming traffic on ports 30333 and 30433
sudo ufw allow 30333/tcp
sudo ufw allow 30433/tcp

# Enable automatic system updates
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades

# Download Subspace CLI binary
wget https://github.com/subspace/subspace-cli/releases/download/v0.3.1-alpha/subspace-cli-ubuntu-x86_64-v3-v0.3.1-alpha
