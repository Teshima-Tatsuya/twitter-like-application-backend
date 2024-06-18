#!/bin/bash -e

kind create cluster --config=kind-config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
podman save localhost/rails -o rails.tgz
kind load image-archive rails.tgz
podman save localhost/nginx -o nginx.tgz
kind load image-archive nginx.tgz
kubectl apply -k .