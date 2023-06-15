#!/bin/sh

# Install docker
echo '\n-------------------------- Install Docker --------------------------'
sleep 10
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

# Setup kubectl
echo '\n-------------------------- Install Kubectl --------------------------'
sleep 10
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Setup k3d
echo '\n-------------------------- Install K3d --------------------------'
sleep 10
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Creating Cluster
echo '\n-------------------------- Creating Cluster --------------------------'
sleep 10
sudo k3d cluster create my-cluster --port 80:80@loadbalancer --port 443:443@loadbalancer

# Creating Namespace
echo '\n-------------------------- Creating Namespaces --------------------------'
sleep 10
sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl create namespace gitlab


# Creating Namespace
echo '\n-------------------------- Applying Config --------------------------'
sleep 50
sudo kubectl apply -n argocd -f ../confs/argocd/install.yaml
sudo kubectl apply -n argocd -f ../confs/argocd/ingress.yaml
sudo kubectl apply -f ../confs/gitlab/gitlab-pvcs.yml -n gitlab
sudo kubectl apply -f ../confs/gitlab/gitlab-secret.yml -n gitlab
sudo kubectl apply -f ../confs/gitlab/gitlab-deployment.yml -n gitlab
sudo kubectl apply -f ../confs/gitlab/gitlab-service.yml -n gitlab
sudo kubectl apply -f ../confs/gitlab/gitlab-ingress.yml -n gitlab
# sudo kubectl apply -n argocd -f argo-application.yaml
