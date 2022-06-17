#!/bin/bash

# for a TAP cluster with basic supply chain deployed - adds 'testing' supply chain.
#  workloads will be picked up by the testing supply chain if they have the label; apps.tanzu.vmware.com/has-tests: "true" 
#
# 


# Install and configure "Testing" supply chain
kubectl -n tap-install get secret ootb-supply-chain-basic-values -o jsonpath="{.data.values\.yml}" | base64 -d - > /tmp/values.yaml
tanzu -n tap-install package install ootb-supply-chain-testing  -p ootb-supply-chain-testing.tanzu.vmware.com  -v 0.7.0 --values-file /tmp/values.yaml
rm /tmp/values.yaml


# Install and configure "Testing and Scanning" supply chain - adds 3rd required selector "apps.tanzu.vmware.com/scan-workload":"true"
kubectl -n tap-install get secret ootb-supply-chain-basic-values -o jsonpath="{.data.values\.yml}" | base64 -d - > /tmp/values.yaml
tanzu -n tap-install package install ootb-supply-chain-testing-scanning -p ootb-supply-chain-testing-scanning.tanzu.vmware.com -v 0.7.0 --values-file /tmp/values.yaml
rm /tmp/values.yaml


sleep 5


kubectl patch clustersupplychains.carto.run source-test-scan-to-url -p '{"spec":{"selector":{"apps.tanzu.vmware.com/scan-workload":"true"}}}' --type 'merge'
kubectl patch clustersupplychains.carto.run scanning-image-scan-to-url -p '{"spec":{"selector":{"apps.tanzu.vmware.com/scan-workload":"true"}}}' --type 'merge'

# tests
# test1 deploy basic workload
echo tdemo1basic deploying source-2-url supplychain
tanzu apps workload create tdemo1basic --git-repo https://github.com/tfynes-pivotal/tdemo1 --git-branch main --type web --label=apps.kubernetes.io/part-of=tdemo1basic -y

# test2 deploy testing workload
echo tdemo1withtests deploying test-2-url supplychain
tanzu apps workload create tdemo1test --git-repo https://github.com/tfynes-pivotal/tdemo1 --git-branch main --type web --label apps.tanzu.vmware.com/has-tests=true --label=apps.kubernetes.io/part-of=tdemo1test -y

# test3 deploy testing and scanning workload
echo tdemo1withtestsandscan deploying scan-test-2-url supplychain
tanzu apps workload create tdemo1scantest --git-repo https://github.com/tfynes-pivotal/tdemo1 --git-branch main --type web --label apps.tanzu.vmware.com/has-tests=true --label apps.tanzu.vmware.com/scan-workload=true --label=apps.kubernetes.io/part-of=tdemo1scantest  -y
