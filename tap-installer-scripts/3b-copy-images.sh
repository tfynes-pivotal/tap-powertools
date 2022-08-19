#!/bin/bash

imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:1.2.1 --to-repo 192.169.3.200.nip.io/tanzunet-mirror/tap-packages --include-non-distributable-layers --registry-ca-cert-path /tmp/foo

#imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:100.0.321 --to-repo=192.169.3.200.nip.io/tbs-dependencies/tbs-full-deps --registry-ca-cert-path /tmp/foo
#tanzu package repository add tbs-full-deps-repository --url 192.169.3.200.nip.io/tbs-dependencies/tbs-full-deps:100.0.321 --namespace tap-install
#tanzu package install full-tbs-deps -p full-tbs-deps.tanzu.vmware.com -v 100.0.321 -n tap-install
