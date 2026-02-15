#!/bin/bash

# Exit on error
set -e

# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://get.docker.com | sudo sh
sudo systemctl enable docker
sudo systemctl start docker

# Add Kubernetes repo and install
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet

# Disable swap
sudo swapoff -a
sudo sed -i '/swap/ s/^\(.*\)$/#\1/' /etc/fstab

# Initialize Kubernetes cluster
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Set up kubectl for the user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Kubernetes installed! Follow kubeadm instructions to apply a network add-on (like Calico or Flannel)."
