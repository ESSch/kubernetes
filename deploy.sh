#!/bin/sh

IMAGE_VERSION="0.6"
export IMAGE="essch/su22:"${IMAGE_VERSION}; 

# no use the apply: pod not wath the update image. Use the delete and the create.
docker build -t ${IMAGE} .
docker image push essch/su22
kubectl delete -f deploymnet.yaml
cat deploymnet.yaml | sed 's!\${IMAGE}!essch/su22:0.6!' | kubectl apply -f -

while kubectl get pods | grep nginxlamp | grep Running
do
  sleep 10;
done;
kubectl apply -f loadbalancer.yaml

while kubectl get -f loadbalancer.yaml -o json | jq -r .status.loadBalancer.ingress[0].ip | grep -P '\d\d.\d\d\d.\d\d.\d\d\d'
do
  sleep 10;
done;
kubectl get -f loadbalancer.yaml -o json | jq -r .status.loadBalancer.ingress[0].ip
