#!/bin/sh -xe
kubectl create namespace example-website
kubectl apply -f example-website-deployment.yaml
kubectl apply -f example-website-service.yaml
