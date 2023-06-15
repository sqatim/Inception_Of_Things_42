#!/bin/sh

kubectl apply -f /vagrant/confs/apps-deployment.yml
kubectl apply -f /vagrant/confs/apps-service.yml
kubectl apply -f /vagrant/confs/apps-ingress.yml