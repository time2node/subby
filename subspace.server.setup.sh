#!/bin/bash

# Update the package list and upgrade packages
apt update && apt upgrade -y

# Install essential packages
apt install -y curl htop file fail2ban build-essential nginx jq certbot python3-certbot-nginx ufw vim git netcat cron unzip atop lshw cifs-utils lsof gnupg unzstd tmux aria2 reiserfsprogs lz4 sysstat ntp

# Set timezone to UTC
timedatectl set-timezone UTC

# Add subspaceadmin user and add to sudo group
adduser subspaceadmin
usermod -aG sudo subspaceadmin

# Enable automatic updates
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades

# Download and install subspace-cli
cd /root/.config
mkdir subspace-cli
cd subspace-cli
wget https://github.com/subspace/community-node/releases/download/v0.3.1-alpha/subspace-cli-ubuntu-x86_64-v3-v0.3.1-alpha
sudo chmod +x subspace-cli-ubuntu-x86_64-v3-v0.3.1-alpha

# Start subspace-cli server
./subspace-cli farm > /dev/null 2>&1 &

# Allow ports 30333 and 30433
sudo ufw allow 30333/tcp
sudo ufw allow 30433/tcp

# Configure sshd_config file
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Restart ssh service
sudo systemctl restart ssh

# Configure fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Automatic system updates
sudo systemctl enable --now apt-daily{,-upgrade}.{timer,service}

# Start ntp service
sudo systemctl start ntp

