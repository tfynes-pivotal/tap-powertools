#!/bin/bash
# assumption that tanzunet registry secret already configured for tap-install namespace
tanzu package repository add scg-package-repository --namespace tap-install --url 192.169.3.200.nip.io/tanzunet-mirror/scg-package-repository:1.1.5
tanzu package install spring-cloud-gateway --namespace tap-install --package-name spring-cloud-gateway.tanzu.vmware.com --version 1.1.5
