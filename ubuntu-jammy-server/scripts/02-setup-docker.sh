#!/bin/bash

# Exit on error
set -e

# Update package list and install dependencies
echo "Updating package list and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Set up Docker repository
echo "Setting up Docker's official apt repository..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to apt sources
echo "Adding Docker's repository to apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again
echo "Updating package list after adding Docker repository..."
sudo apt-get update

# Install Docker Engine and its components
echo "Installing Docker Engine and required components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker Engine installation
echo "Verifying Docker installation by running 'hello-world' container..."
sudo docker run hello-world

echo "Docker has been successfully installed and verified!"
