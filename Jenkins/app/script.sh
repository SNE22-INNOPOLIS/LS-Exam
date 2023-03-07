#!/bin/bash

sudo apt-get update || true
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release || true

sudo mkdir -m 0755 -p /etc/apt/keyrings || true
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || true
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || true

sudo apt-get update || true
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || true
sudo apt-get install -y docker-compose || true
sudo usermod -aG docker ubuntu || true

sudo docker-compose up -d --build

sudo docker logs jenkins | less > /tmp/jenkins_init_passwd

sudo cat /tmp/jenkins_init_passwd