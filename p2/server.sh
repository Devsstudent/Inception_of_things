#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
sudo apt-get update -y
sudo apt-get install vim curl -y
source .env
cp /etc/environment /etc/systemd/system/k3s.service.env
curl -sfL https://get.k3s.io | sh -s - server --node-ip 192.168.56.110 --advertise-address 192.168.56.110 --write-kubeconfig-mode 644 --token inception 
sudo mkdir -p /home/vagrant/.kube
sudo cp -R /vagrant/app* /home/vagrant
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

kubectl create -f /vagrant/app1/app1.yaml
kubectl create -f /vagrant/app2/app2.yaml
kubectl create -f /vagrant/app3/app3.yaml
kubectl create -f /vagrant/ingress.yaml

#sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/node-token
#sudo ufw disable
