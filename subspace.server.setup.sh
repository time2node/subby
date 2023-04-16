{\rtf1\ansi\ansicpg1252\cocoartf2708
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
# Install required packages\
apt update\
apt install -y pip curl htop file build-essential nginx jq certbot python3-certbot-nginx ufw vim git netcat cron unzip atop lshw cifs-utils lsof libusb-1.0-0/focal pkg-config gnupg unzstd tmux aria2 reiserfsprogs lz4 sysstat\
\
# Configure SSH\
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config\
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config\
sudo systemctl restart ssh\
\
# Install fail2ban\
sudo apt install fail2ban -y\
sudo systemctl enable fail2ban\
sudo systemctl start fail2ban\
\
# Add new user\
sudo adduser subspaceadmin\
\
# Add user to sudo group\
sudo usermod -aG sudo subspaceadmin\
\
# Allow incoming traffic on ports 30333 and 30433\
sudo ufw allow 30333/tcp\
sudo ufw allow 30433/tcp\
\
# Enable automatic system updates\
sudo apt install unattended-upgrades -y\
sudo dpkg-reconfigure -plow unattended-upgrades\
\
# Download Subspace CLI binary\
wget https://github.com/subspace/subspace-cli/releases/download/v0.3.1-alpha/subspace-cli-ubuntu-x86_64-v3-v0.3.1-alpha\
}