# Inception-of-Things: Part 3 (K3d & Argo CD)

This project automates the deployment of a local Kubernetes cluster using **k3d** and implements a **GitOps** Continuous Delivery pipeline using **Argo CD**.

---

## 📁 Project Structure

```text
.
├── Vagrantfile               # VM configuration (4GB RAM, 2 CPUs)
├── confs/
│   ├── install.yaml          # Argo CD manifests
│   └── application.yaml      # Argo CD Application Controller manifest
├── scripts/
│   ├── install.sh            # Tool installation (Docker, k3d, kubectl)
│   ├── setup_cluster.sh      # Cluster creation and Argo CD setup
│   └── clean.sh              # Environment cleanup
└── README.md                 # Project documentation
```

---

## 🚀 Step-by-Step Instructions

Follow these exact steps to deploy and access the environment:

### 1. Create the Virtual Machine
From your host terminal, run:
```bash
vagrant up moharrasS
```

### 2. Access the Virtual Machine
Log into the newly created CentOS instance:
```bash
vagrant ssh moharrasS
```

### 3. Setup the Cluster
Inside the VM, execute the setup script to create the cluster and install Argo CD:
```bash
sh /vagrant/scripts/setup_cluster.sh
```
*Wait for the script to finish. It will print the **Argo CD Admin Password** at the end.*

### 4. Clean the Environment
If you want to delete the cluster and start fresh, run:
```bash
sh /vagrant/scripts/clean.sh
```

---

## 🌐 Accessing the Services

Once the setup is complete, you can access the following from your **Host Browser**:

| Service | Access URL | Credentials |
| :--- | :--- | :--- |
| **Web App** | [http://localhost:8081](http://localhost:8081) | Public |
| **Argo CD UI** | [https://localhost:8080](https://localhost:8080) | User: `admin` / Password: `<from_script>` |

> **Note:** Accessing Argo CD requires **HTTPS**. Your browser will show a certificate warning; click **Advanced** and **Proceed to localhost**.

---
