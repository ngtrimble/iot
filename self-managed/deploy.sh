#!/usr/bin/env bash
set -o pipefail

# Ensure namespace exists
kubectl create namespace mosquitto --dry-run=client -o yaml | kubectl apply -f -

# Create a password file for mosquitto and store it as a kubernetes secret
mosquitto_passwd -c -b passwd iotdev abcd1234
kubectl delete secret -n mosquitto mosquitto-passwd
kubectl create secret generic -n mosquitto mosquitto-passwd --from-file=passwd 

# Deploy Mosquitto
kubectl apply -f mosquitto.yaml

# Deploy InfluxDB 3, caveat, this is Enteprise and not what is wanted. Core is more complex to install
# helm repo add influxdata https://helm.influxdata.com/
# help repo update
# helm upgrade influxdb influxdata/influxdb3-clustered --install -f  --namespace influxdb --create-namespace

# Deploy InfluxDB 3 Core
kubectl apply -f influxdb3-core.yaml
