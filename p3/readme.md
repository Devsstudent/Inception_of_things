### Process

Run
```
k3d cluster create --config k3d-config.yaml
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
Wait argocd pods creation, then in background expose port:
```
 kubectl port-forward svc/argocd-server -n argocd 8080:443
```


We can then access argocd on localhost:8080

use: 
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```
to get the password of admin user.

Register a new app with:

https://github.com/Devsstudent/toliver-iot.git

make sure to set the path to app
