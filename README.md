# TAP Powertools


TKGi TAP deployment scripts

TKGI TAP with Private-Registry overlay fixes to inject private CA certs as necessary

TAP useful functions tap-nudge, tap-schema
  tap-nudge to 'nudge' reconcilers
  
  tap-schema to output allowed configuration values for TAP packages


Updated tkgi/tkgi-install content with command-sequence for from-scratch TAP/TKGI dpeloyment including augmented SpringCloudGateway operator installation
Steps 1-7 to deploy TAP and SCG-operator - enabled default namespace for developer-use.

step 8-create-tdemo1-workload.sh creates a public 'tdemo1-default.<tap-ingress-domain>' service.. 

test with curl command

delete workload with 

tanzu apps workload delete tdemo1

now create updated tdemo1 workload but exposed only on a cluster-local endpoint

show how curl command fails to access deployed workload

create and configure SCG gateway to access protected tdemo1 endpoint
 9-create-scg-tdemo1-gateway.sh does the following
	Create SCG using operator
	Configure HTTP proxy to expose SCG instance on TAP ingress domain (tdemo1.<ingress domain>)
	Configure SCG-route-config to expose protected tdemo1 internal kService
	Add SCG-route-mapping to assocaite route configuration with SCG instance.


