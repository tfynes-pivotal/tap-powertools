#!/bin/bash
kubectl create ns metallb-system
kubectl -n metallb-system apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl -n metallb-system apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
kubectl apply -f ./metalcm2.yaml
