#!/bin/sh

set -x
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.7.2/deploy/longhorn.yaml
kubectl apply -f ingress.yaml

