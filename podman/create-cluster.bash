#!/bin/bash -e

KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --config=kind-config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
podman save localhost/rails -o rails.tgz
KIND_EXPERIMENTAL_PROVIDER=podman kind load image-archive rails.tgz
kubectl apply -k .