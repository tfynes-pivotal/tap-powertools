#!/bin/bash

# create tdemo1 scg gateway instance
kubectl apply -f ./tdemo1-scg.yaml

# create http proxy for tdemo1 ingress
kubectl apply -f ./tdemo1-scg-httpproxy.yaml

# apply tdemo1 scg route config
kubectl apply -f ./tdemo1-scgrc.yaml

# apply tdemo1 scg route mapping
kubectl apply -f ./tdemo1-scgm.yaml
