#!/bin/sh


k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
# this give the password and the username is admin

docker pull wil42/playground:v1
docker pull wil42/playground:v2

kubectl create -f ./pod.yaml


kubectl config set-context --current --namespace=argocd

#argocd login  http://localhost:8080

