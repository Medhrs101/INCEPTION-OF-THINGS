#!/bin/bash

apt-get update && apt-get install -y curl
apt-get install -y net-tools

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="server \
--node-ip=$master_ip \
--flannel-iface=eth1 \
--write-kubeconfig-mode 644" \
sh -

echo "alias k='sudo /usr/local/bin/k3s kubectl'" >> /home/vagrant/.bashrc
kubectl apply -f /vagrant/deployment.yaml
kubectl apply -f /vagrant/service.yaml
kubectl apply -f /vagrant/ingress.yaml