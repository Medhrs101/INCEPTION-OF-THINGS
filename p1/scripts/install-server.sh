#!/bin/bash

apt-get update && apt-get install -y curl
apt-get install -y net-tools

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="server \
--node-ip=$master_ip \
--flannel-iface=eth1 \
--write-kubeconfig-mode 644" \
sh -

until [ -f /var/lib/rancher/k3s/server/token ]; do
  echo "Waiting for K3s token to be generated..."
  sleep 2
done

cp /var/lib/rancher/k3s/server/token /vagrant/token
echo "alias k='sudo /usr/local/bin/k3s kubectl'" >> /home/vagrant/.bashrc
