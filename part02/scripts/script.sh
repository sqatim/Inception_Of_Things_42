#!/bin/sh

/usr/local/bin/kubectl apply -f /vagrant/confs/apps-deployment.yml
/usr/local/bin/kubectl apply -f /vagrant/confs/apps-service.yml
/usr/local/bin/kubectl apply -f /vagrant/confs/apps-ingress.yml