#!/bin/bash
# assumption that tanzunet registry secret already configured for tap-install namespace
tanzu package repository add scg-package-repository --namespace tap-install --url registry.tanzu.vmware.com/spring-cloud-gateway-for-kubernetes/scg-package-repository:1.1.0
tanzu package install spring-cloud-gateway --namespace tap-install --package-name spring-cloud-gateway.tanzu.vmware.com --version 1.1.0
