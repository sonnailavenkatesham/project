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

sudo docker run -d \
  --name nexus \
  -p 8081:8081 \
  -v nexus-data:/nexus-data \
  --restart unless-stopped \
  sonatype/nexus3
