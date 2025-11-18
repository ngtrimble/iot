#!/usr/bin/env bash
set -e -o pipefail

# Create Test Input
kubectl apply -f test-publish-job.yaml
