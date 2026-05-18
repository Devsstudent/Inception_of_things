#!/bin/sh

# https://docs.gitlab.com/charts/installation/

# helm inspect values for the config of helms (very useful)

k3d cluster create --config k3d-config.yaml

helm repo add gitlab https://charts.gitlab.io
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

kubectl create namespace gitlab

#kubectl apply -f gitlab_conf.yaml -n gitlab

helm upgrade --install gitlab gitlab/gitlab \
  --namespace gitlab --set global.hosts.domain=iot.com --set global.hosts.https=false   --set certmanager-issuer.email=me@example.com

kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 --decode ; echo

kubectl -n gitlab port-forward svc/gitlab-webservice-default 8080:8181

# We have to create a gitlab user, and create a project and push the same as the toliver-iot like in p3.

# Also on the /etc/hosts edit to add 127.0.0.1 gitlab.iot.com

kubectl edit configmap coredns -n kube-system

# add the clusterIp of gitlab-nginx-ingress-controller           LoadBalancer   10.43.236.160   <pending>     80:30787/TCP,443:31591/TCP,22:30777/TCP   90m

# to the hosts in Corefile (DNS kube)

# donc ajouter ClusterIP (example 10.43.246.160) gitlab.iot.com

kubectl rollout restart deployment coredns -n kube-system


kubectl create namespace argocd

helm upgrade --install argocd argocd/argocd \
  --namespace argocd

kubectl config set-context --current --namespace=argocd

kubectl get secret argocd-initial-admin-secret  -ojsonpath='{.data.password}' | base64 --decode ; echo

kubectl -n argocd port-forward svc/argocd-server  8001:80

argocd login  localhost:8001

argocd repo add http://gitlab.iot.com/orson/test.git \
  --username <your-user> \
  --password <your-token> \
  --insecure-skip-server-verification

# Then on argocd it's working


