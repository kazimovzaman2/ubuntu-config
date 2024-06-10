#!/bin/bash

# Update package list and upgrade all packages
sudo apt update -y && sudo apt upgrade -y

# Install build essentials
sudo apt install -y build-essential

# Install Git
sudo apt install -y git

# Install wget
sudo apt install -y wget

# Install Python and related tools
sudo apt install -y python3 python3-pip python3-venv

# Install Node.js and npm
sudo apt install -y nodejs npm

# Install Docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add your user to the Docker group
sudo usermod -aG docker ${USER}

# Cleanup
sudo apt autoremove -y && sudo apt clean -y

echo "Installation complete. Please log out and log back in to apply Docker group changes."

