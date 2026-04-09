#!/bin/bash

# 1. Update and install basic tools
sudo dnf update -y
sudo dnf install -y yum-utils curl wget

# 2. Install Docker
if ! command -v docker &> /dev/null; then
    sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable --now docker
    sudo usermod -aG docker vagrant
fi

# 3. Install kubectl & k3d
[ ! -f /usr/local/bin/kubectl ] && {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

command -v k3d &> /dev/null || curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# 4. Ensure scripts are executable
chmod +x /vagrant/scripts/*.sh

echo "Installation of tools complete."