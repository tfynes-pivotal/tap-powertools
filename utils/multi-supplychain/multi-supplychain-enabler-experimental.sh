#!/bin/bash
echo *** NO LONGER OPTIMAL APPROACH - USE MULTI-SUPPLYCHAIN-INSTALLER SCRIPT / OPTION ***
echo *** NO NEED FOR UNIQUE SELECTOR ***
echo
echo TAP Multi-SupplyChain Enabler
echo
echo Augment your TAP cluster to support basic and testing supply chains in parallel
echo   basic supply chain selector 'type' remains "web"
echo   testing supply chain selector 'type' becomes "webwithtests" 
echo      with label  apps.tanzu.vmware.com/has-tests=true
echo
echo Prerequisites:
echo   Update your tap-values.yaml and enable your tap cluster to support the "testing" supply chain before continuing
echo   kubectl configured to point to TAP cluster
echo   yq installed locally
echo  
echo 
echo Script will execute following tasks
echo   1. Download testing supply chains testing-image-to-url and source-test-to-url
echo   2. Scrub annotations/labels and clean yaml definitions
echo   3. Update testing selector from 'web' to 'webwithtests'
read -p "Press key to continue"

echo   Downloading testing supply chain yamls testing-image-to-url and source-test-to-url
kubectl get clustersupplychains.carto.run source-test-to-url -o yaml > source-test-to-url.yaml
kubectl get clustersupplychains.carto.run testing-image-to-url  -o yaml > testing-image-to-url.yaml
echo
echo
echo  Removing annotations, labels and status
yq e '.spec.selector."apps.tanzu.vmware.com/workload-type" = "webwithtests"' source-test-to-url.yaml > temp.yaml
yq 'del(.metadata.annotations, .metadata.creationTimestamp, .metadata.generation, .metadata.labels, .metadata.resourceVersion, .metadata.uid, .status)' temp.yaml > source-test-to-url.yaml
rm temp.yaml

yq e '.spec.selector."apps.tanzu.vmware.com/workload-type" = "webwithtests"' testing-image-to-url.yaml > temp.yaml
yq 'del(.metadata.annotations, .metadata.creationTimestamp, .metadata.generation, .metadata.labels, .metadata.resourceVersion, .metadata.uid, .status)' temp.yaml > testing-image-to-url.yaml
rm temp.yaml

echo 
echo Updates complete
echo 
echo Update tap-values.yaml and enable cluster to support the "basic" supply chain
echo  Once update has completed - validate with kubectl get clustersupplychain - should see \"basic-image-to-url\" and \"source-to-url\"
echo  Side-load in testing supply chain with following command
echo    kubectl apply -f ./source-test-to-url.yaml 
echo    kubectl apply -f ./testing-image-to-url.yaml
echo
echo test workload with basic supply chain
echo tanzu apps workload create tdemo1notests --git-repo https://github.com/tfynes-pivotal/tdemo1 --git-branch main --type web --label="apps.kubernetes.io/part-of=tdemo1notests" -y
echo test workload with testing supply chain
echo tanzu apps workload create tdemo1withtests --git-repo https://github.com/tfynes-pivotal/tdemo1 --git-branch main --type webwithtests --label="apps.kubernetes.io/part-of=tdemo1withtests"  --label apps.tanzu.vmware.com/has-tests=true -y
echo

