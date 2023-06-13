#!/bin/sh


sudo ufw allow 22
sudo ufw allow 2222
sudo ufw enable
echo '-------------------------- Deleting cluster --------------------------'
k3d cluster delete my-cluster
echo '-------------------------- Creating cluster --------------------------'
sleep 10
k3d cluster create my-cluster --port 80:80@loadbalancer --port 8443:443@loadbalancer
echo '-------------------------- Creating Namespace --------------------------'
sleep 10
kubectl create namespace gitlab
echo '-------------------------- Applying Config --------------------------'
sleep 50
kubectl apply -f gitlab-pvcs.yml -n gitlab
kubectl apply -f gitlab-secret.yml -n gitlab
kubectl apply -f gitlab-deployment.yml -n gitlab
kubectl apply -f gitlab-service.yml -n gitlab
kubectl apply -f gitlab-ingress.yml -n gitlab