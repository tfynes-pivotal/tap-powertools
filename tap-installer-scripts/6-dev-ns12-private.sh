#!/bin/bash
tanzu secret registry delete registry-credentials -y
tanzu secret registry add registry-credentials --server $PRIVATE_REGISTRY_SERVER --username $PRIVATE_REGISTRY_USERNAME --password $PRIVATE_REGISTRY_PASSWORD
kubectl apply -f ./devns12.yaml
