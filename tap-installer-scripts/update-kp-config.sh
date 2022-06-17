#!/bin/bash
repo=$(kubectl -n kpack get cm kp-config -o "jsonpath={.data.default\.repository}")
kubectl -n kpack patch configmap kp-config --type merge -p "{\"data\":{\"canonical.repository\":\"$repo\"}}"


sa=$(kubectl -n kpack get cm kp-config -o "jsonpath={.data.default\.repository\.serviceaccount}")
kubectl -n kpack patch configmap kp-config --type merge -p "{\"data\":{\"canonical.repository.serviceaccount\":\"$sa\"}}"
