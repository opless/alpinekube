#!/bin/sh
set -x
kubectl create namespace kubernetes-dashboard
for i in 00-create-service-account.yaml 01-create-cluster-role-binding.yaml 02-create-long-lived-secret.yaml 03-ingress.yaml
do
  kubectl apply -f $i
done

