#!/bin/bash

# Update package list and install sudo
apt-get update
apt-get install -y sudo

# Generate a random password
PASSWORD=$(openssl rand -base64 12)

# Create the user 'homeassistant' with the generated password
useradd -m -s /bin/bash homeassistant
echo "homeassistant:$PASSWORD" | chpasswd

echo "User 'homeassistant' created with a generated password."

# Store the password in a text file
echo "homeassistant password: $PASSWORD" > /home/homeassistant/password.txt
chmod 600 /home/homeassistant/password.txt

# Notify user of completion
echo "Password stored in /home/homeassistant/password.txt"

# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
usermod -aG docker homeassistant

# Notify user of completion
echo "Docker has been successfully installed!"

# Install git
sudo apt install git-all

# Get home-assistant-build
git clone https://github.com/PaTara43/home-assistant-build /home/homeassistant
sudo chown -R homeassistant:homeassistant /home/homeassistant/home-assistant-build
sudo apt-get install wget unzip git jq
