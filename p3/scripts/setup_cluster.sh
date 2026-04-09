#!/bin/bash

# 1. Create Cluster
# We map 8081 for the app. We will use port-forward for Argo on 8080.
if ! k3d cluster list | grep -q "iot-cluster"; then
    k3d cluster create iot-cluster --port 8081:30080@loadbalancer
fi

# 2. Download Manifest & Verify (Ensures it is NOT empty)
mkdir -p /vagrant/confs
echo "Downloading Argo CD..."
wget -q https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -O /vagrant/confs/install.yaml

if [ ! -s "/vagrant/confs/install.yaml" ]; then
    echo "Error: Download failed or file is empty."
    exit 1
fi

# 3. Install Argo CD
kubectl create namespace argocd
echo "Applying Argo CD manifests..."
kubectl create -f /vagrant/confs/install.yaml -n argocd

# 4. Wait for Argo CD (Replaces 'sleep 20')
echo "Waiting for Argo CD pods to be ready..."
kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s

# 5. Deploy Application
if [ -f /vagrant/confs/application.yaml ]; then
    echo "Deploying Application..."
    # Small sleep to allow CRDs to register in the API
    sleep 5
    kubectl apply -f /vagrant/confs/application.yaml
fi

# 6. Port-Forward (Using 8080 to match your Vagrantfile)
pkill -f "port-forward"
echo "Starting port-forward on 8080..."
kubectl port-forward -n argocd svc/argocd-server 8080:443 --address 0.0.0.0 > /dev/null 2>&1 &

# 7. Get Password
PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "-------------------------------------------------------"
echo "Setup complete!"
echo "Web App: http://localhost:8081"
echo "Argo CD UI: https://localhost:8080"
echo "Username: admin"
echo "Password: $PASS"
echo "-------------------------------------------------------"