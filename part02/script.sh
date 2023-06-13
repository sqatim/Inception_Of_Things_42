#!/bin/sh

kubectl apply -f /vagrant/apps-deployment.yml
kubectl apply -f /vagrant/apps-service.yml
kubectl apply -f /vagrant/apps-ingress.yml