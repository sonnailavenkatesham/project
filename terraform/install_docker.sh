#!/bin/bash
set -e

echo "Updating system..."
apt-get update -y

echo "Removing old Docker versions..."
apt-get remove -y docker docker-engine docker.io containerd runc || true

echo "Installing dependencies..."
apt-get install -y ca-certificates curl gnupg

echo "Adding Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "Adding Docker repo..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -y

echo "Installing Docker..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

echo "Adding ubuntu user to docker group..."
usermod -aG docker ubuntu

echo "Fixing SonarQube kernel requirements..."
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf

echo "Running SonarQube container..."
docker run -d \
  --name sonarqube \
  -p 9000:9000 \
  sonarqube:lts-community

echo "Done!"
