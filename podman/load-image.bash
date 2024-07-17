#!/bin/bash -e

if [ $1 = "rails" ]; then
    pushd ..
    podman build -f ./podman/rails/Containerfile . -t rails
    popd
fi
podman save localhost/$1 -o $1.tgz
kind load image-archive $1.tgz
rm -f $1.tgz

POD_NAME=$(kubectl get pods --selector=app=$1 -o json | jq -r ".items[].metadata.name")
kubectl delete pod ${POD_NAME}