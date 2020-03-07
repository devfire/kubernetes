#!/usr/bin/env bash

mkdir certs
openssl req -nodes -newkey rsa:2048 -keyout certs/dashboard.key -out certs/dashboard.csr -subj "/CN=kubernetes-dashboard"
openssl x509 -req -sha256 -days 365 -in certs/dashboard.csr -signkey certs/dashboard.key -out certs/dashboard.crt
/snap/bin/microk8s.kubectl create secret generic kubernetes-dashboard-certs --from-file=certs -n kube-system
/snap/bin/microk8s.kubectl delete pod -n kube-system -l k8s-app=kubernetes-dashboard