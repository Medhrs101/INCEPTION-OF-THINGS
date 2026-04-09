#!/bin/bash

echo "Cleaning environment..."

# 1. Delete Cluster
k3d cluster delete iot-cluster 2>/dev/null

# 2. Kill Port-forwards
pkill -f "port-forward" 2>/dev/null

# 3. Remove downloaded manifest
rm -f /vagrant/confs/install.yaml
rm -f /vagrant/confs/application.yaml

echo "Cleanup complete. Environment is fresh."