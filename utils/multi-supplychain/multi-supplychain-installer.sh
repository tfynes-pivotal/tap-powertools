#!/bin/bash

# for a TAP cluster with basic supply chain deployed - adds 'testing' supply chain.
#  workloads will be picked up by the testing supply chain if they have the label; apps.tanzu.vmware.com/has-tests: "true" 
#
# 

kubectl -n tap-install get secret ootb-supply-chain-basic-values -o jsonpath="{.data.values\.yml}" | base64 -d - > /tmp/values.yaml
tanzu -n tap-install package install ootb-supply-chain-testing  -p ootb-supply-chain-testing.tanzu.vmware.com  -v 0.7.0 --values-file /tmp/values.yaml
rm /tmp/values.yaml


#kubectl patch clustersupplychains.carto.run source-test-to-url -p '{"spec":{"selector":{"apps.tanzu.vmware.com/workload-type":"webwithtests"}}}' --type 'merge'
