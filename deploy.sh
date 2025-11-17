#!/usr/bin/env bash
set -o pipefail

# Ensure namespace exists
kubectl create namespace mosquitto --dry-run=client -o yaml | kubectl apply -f -

# Create a password file for mosquitto and store it as a kubernetes secret
mosquitto_passwd -c -b passwd iotdev abcd1234
kubectl delete secret -n mosquitto mosquitto-passwd
kubectl create secret generic -n mosquitto mosquitto-passwd --from-file=passwd 

# Deploy backend
kubectl apply -f mosquitto.yaml

# Create Test Input
kubectl apply -f test-publish-job.yaml
