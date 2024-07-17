#!/bin/bash

mkdir -p ./postgresql/data && chmod 777 ./postgresql/data
kind create cluster --config=kind-config.yaml

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

# rails job
for i in {1..10}; do
  echo "Waiting for postgresql..${i}/10"
  sleep 5;
  STATUS=$(kubectl get pods --selector app=postgresql -o json | jq -r ".items[].status.containerStatuses[].ready");
  echo ${STATUS}
  if [ ${STATUS} = "true" ]; then
    break;
  fi
  if [ ${i} -eq 10 ]; then
    echo "postgresqlが正しく起動されませんでした"
    exit 255;
  fi
done

kubectl apply -f ./rails/jobs/job-db-create.yaml
sleep 5
kubectl apply -f ./rails/jobs/job-db-migrate.yaml