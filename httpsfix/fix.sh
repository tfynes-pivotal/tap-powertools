#!/bin/bash

echo "Creating Secret defining overlay fix (httpsfixer)"
kubectl -n tap-install create secret generic httpsfixer --from-file ./cm.yaml

echo "Updating tap PackageInstall to load overlay from secret and create profile specific overlay config for CNRS packageInstall (https-scheme-overlay-secret)"
kubectl patch -n tap-install --type merge pkgi tap --patch '{"metadata":{"annotations":{"ext.packaging.carvel.dev/ytt-paths-from-secret-name.0": "httpsfixer"}}}'

# ext.packaging.carvel.dev/ytt-paths-from-secret-name.0: httpsfixer

echo 
echo APPEND TO TAP-VALUES.YAML
echo
echo package_overlays:
echo - name: cnrs
echo   secrets:
echo   - name: https-scheme-overlay-secret

echo 
echo Update TAP configuration
echo tanzu -n tap-install package installed update tap -f ./tap-values.yaml

echo 
echo Delete stale knative-serving network-config configmap
echo kubectl -n knative-serving delete configmap config-network
