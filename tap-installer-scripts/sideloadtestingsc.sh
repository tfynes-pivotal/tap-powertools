#!/bin/bash
kubectl -n tap-install get secret ootb-supply-chain-basic-values -o jsonpath="{.data.values\.yml}" | base64 -d - > /tmp/values.yaml
tanzu -n tap-install package install ootb-supply-chain-testing  -p ootb-supply-chain-testing.tanzu.vmware.com  -v 0.7.0 --values-file /tmp/values.yaml
rm /tmp/values.yaml
