#!/bin/bash
tanzu package install tap -p tap.tanzu.vmware.com -v 1.2.1 -n tap-install --values-file $1
