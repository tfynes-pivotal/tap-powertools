#!/bin/bash
tanzu package install tap -p tap.tanzu.vmware.com -v 1.2.1 -n tap-install --values-file $1

# Must now add tbs dependencies

# import the TBS dependencies from Pivnet
echo imgpkg copy -b registry.tanzu.vmware.com/tbs-dependencies/full:100.0.321 --to-repo 192.169.3.200.nip.io/tbs-dependencies/tbs-dependencies --registry-ca-cert-path /tmp/foo --include-non-distributable-layers

#patch the kp-config configmap (bug workaround)
# update-kp-config.sh                               


# create TBS ClusterStore etc...
echo imgpkg pull -b 192.169.3.200.nip.io/tbs-dependencies/tbs-dependencies:100.0.321  -o /tmp/descriptor-bundle  --registry-ca-cert-path /tmp/foo
echo kbld -f /tmp/descriptor-bundle/.imgpkg/images.yml -f /tmp/descriptor-bundle/tanzu.descriptor.v1alpha3/descriptor-100.0.321.yaml | kp import -f - --registry-ca-cert-path /tmp/foo
