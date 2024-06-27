#!/bin/bash -e

kind create cluster --config=kind-config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# rails
pushd ../
podman build -f ./podman/rails/Containerfile . -t rails
popd
podman save localhost/rails -o rails.tgz
kind load image-archive rails.tgz
rm ./rails.tgz

# nginx
podman build ./nginx -t nginx
podman save localhost/nginx -o nginx.tgz
kind load image-archive nginx.tgz
rm ./nginx.tgz

# apply all
kubectl apply -k .