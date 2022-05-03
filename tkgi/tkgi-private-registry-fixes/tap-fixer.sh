#!/bin/bash

function pause(){
   echo Press any key to continue...
   read -p "$*"
}

echo  "Ensure TAP deployment has completed (all PackageInstalls in tap-install ns have reconciled)"
pause
echo
echo Loading 'Conventions Controller Fix' - from file ./fixes/conventions-overlay.yaml
kubectl create secret generic -n tap-install convention-service-cert --from-file=./fixes/conventions-overlay.yaml
echo
echo Loading 'Source Controller Fix' - from file ./fixes/sources-overlay.yaml
kubectl create secret generic -n tap-install source-service-cert --from-file=./fixes/sources-overlay.yaml
echo
echo Loading 'OOTB Config Writer Fix' - from file ./fixes/ootb-config-writer-overlay.yaml
kubectl create secret generic -n tap-install ootb-templates-cert --from-file=./fixes/ootb-config-writer-overlay.yaml
echo 
echo
echo Applying fixes to TAP packageinstall via annotation
kubectl patch -n tap-install --type merge pkgi tap --patch '{"metadata":{"annotations":{"ext.packaging.carvel.dev/ytt-paths-from-secret-name.0": "convention-service-cert", "ext.packaging.carvel.dev/ytt-paths-from-secret-name.1":"ootb-templates-cert", "ext.packaging.carvel.dev/ytt-paths-from-secret-name.2": "source-service-cert"}}}'

