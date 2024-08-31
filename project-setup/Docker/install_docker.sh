#!/bin/bash

set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install required packages
echo "Installing required packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker’s APT repository
echo "Adding Docker’s APT repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package list again to include Docker packages
echo "Updating package list again..."
sudo apt update

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
echo "Verifying Docker installation..."
sudo systemctl status docker || true

# Enable Docker to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

# Add user to the Docker group (optional)
read -p "Do you want to add your user to the Docker group? (yes/no): " answer
if [[ "$answer" == "yes" ]]; then
  echo "Adding user to Docker group..."
  sudo usermod -aG docker $USER
  echo "You will need to log out and log back in for the group changes to take effect."
fi

echo "Docker installation completed successfully."
