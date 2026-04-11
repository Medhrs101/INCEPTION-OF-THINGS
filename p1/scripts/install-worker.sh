#!/bin/bash

NODE_TOKEN=$(cat /vagrant/token)
apt-get update && apt-get install -y curl
apt-get install -y net-tools
curl -sfL https://get.k3s.io | \
K3S_URL="https://$master_ip:6443" \
INSTALL_K3S_EXEC="agent --node-ip=$worker_ip --flannel-iface=eth1 --token-file=/vagrant/token" sh -

echo "alias k='sudo /usr/local/bin/k3s kubectl'" >> /home/vagrant/.bashrc