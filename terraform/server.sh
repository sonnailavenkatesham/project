#!/bin/bash

# Update package index
sudo apt update

# Install required dependencies
sudo apt install -y software-properties-common

# Add the Ansible PPA (Personal Package Archive)
sudo add-apt-repository --yes ppa:ansible/ansible

# Update package index again
sudo apt update

# Install Ansible
sudo apt install -y ansible
