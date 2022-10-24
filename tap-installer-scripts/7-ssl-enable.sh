#!/bin/bash

kubectl -n tanzu-system-ingress create secret tls tapfynesycom --cert ~/PIVOTAL/certbot/config/live/tap.fynesy.com/fullchain.pem --key ~/PIVOTAL/certbot/config/live/tap.fynesy.com/privkey.pem
kubectl -n tap-gui create secret tls tapfynesycom --cert ~/PIVOTAL/certbot/config/live/tap.fynesy.com/fullchain.pem --key ~/PIVOTAL/certbot/config/live/tap.fynesy.com/privkey.pem

kubectl apply -f ./tls-to-default-delegation.yaml
