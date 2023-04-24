
export MSTOKEN=$(kubectl get secrets metadata-store-read-write-client -n metadata-store -o jsonpath="{.data.token}" | base64 -d)
echo MSTOKEN= $MSTOKEN
echo
export MSCA=$(kubectl -n metadata-store get secret app-tls-ca-cert -o json | jq -r '.data."ca.crt"')
echo MSCA= $MSCA
echo
export CLUSTER_CA1=$(kubectl config view --minify --flatten -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
echo CLUSTER_CA1=$CLUSTER_CA1
echo
export CLUSTER_URL1=$(kubectl config view --minify -o json | jq -r .clusters[0].cluster.server)
echo CLUSTER_URL1= $CLUSTER_URL1
echo
kubectl apply -f ./tap-gui-viewer-sa-rbac.yaml

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: tap-gui-viewer
  namespace: tap-gui
  annotations:
    kubernetes.io/service-account.name: tap-gui-viewer
type: kubernetes.io/service-account-token
EOF

export CLUSTER_TOKEN1=$(kubectl -n tap-gui get secret tap-gui-viewer -o json |  jq -r '.data["token"]' \
| base64 --decode)

echo CLUSTER_TOKEN1=$CLUSTER_TOKEN1
echo
echo
echo
#tanzu -n tap-install package installed update tap -f <(ytt -f ../../tap-values-aks-template.yaml -v mstoken=$MSTOKEN -v cluster_url1=$CLUSTER_URL1 -v cluster_token1=$CLUSTER_TOKEN1)


echo ytt -f ../../tap-values-aks-15beta-Template.yaml -v cluster1ca=$CLUSTER_CA1 -v msca=$MSCA -v mstoken=$MSTOKEN -v cluster_url1=$CLUSTER_URL1 -v cluster_token1=$CLUSTER_TOKEN1 > /tmp/temp.yaml
ytt -f ../../tap-values-aks-15beta-Template.yaml -v cluster1ca=$CLUSTER_CA1 -v msca=$MSCA -v mstoken=$MSTOKEN -v cluster_url1=$CLUSTER_URL1 -v cluster_token1=$CLUSTER_TOKEN1 > /tmp/temp.yaml


tanzu -n tap-install package installed update tap --values-file /tmp/temp.yaml

