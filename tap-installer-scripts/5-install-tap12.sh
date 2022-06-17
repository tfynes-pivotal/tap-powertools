#!/bin/bash
tanzu package install tap -p tap.tanzu.vmware.com -v 1.2.0-build.13 -n tap-install --values-file $1
