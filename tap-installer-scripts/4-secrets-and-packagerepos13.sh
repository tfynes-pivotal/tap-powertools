#!/bin/bash

export TAP_VERSION='1.3.0'

kubectl create ns tap-install

tanzu secret registry add tap-registry     \
   --username ${INSTALL_REGISTRY_USERNAME} \
   --password ${INSTALL_REGISTRY_PASSWORD} \
   --server ${INSTALL_REGISTRY_HOSTNAME} \
   --export-to-all-namespaces --yes --namespace tap-install

tanzu package repository add tanzu-tap-repository \
  --url registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:$TAP_VERSION \
  --namespace tap-install


tanzu -n tap-install package repository get tanzu-tap-repository

tanzu package available list --namespace tap-install


