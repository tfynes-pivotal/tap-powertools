#!/bin/bash
tanzu secret registry add registry-credentials --server $REGISTRY_SERVER --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD
kubectl apply -f ./devns.yaml
