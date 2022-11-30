#!/bin/bash
tanzu package install tap -p tap.tanzu.vmware.com -v 1.3.2 -n tap-install --values-file $1
