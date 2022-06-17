#!/bin/bash


kubectl create ns kapp-controller
kubectl apply -f ./kapp-secret.yaml

#export INSTALL_BUNDLE
#export INSTALL_REGISTRY_HOSTNAME
#export INSTALL_REGISTRY_USERNAME
#export INSTALL_REGISTRY_PASSWORD

kubectl create ns kapp-controller
kubectl apply -f ./kapp-secret.yaml

pushd ~/tanzu-cluster-essentials
./install.sh
popd

