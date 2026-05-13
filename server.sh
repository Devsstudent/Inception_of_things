#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
sudo apt-get update -y
sudo apt-get install vim curl -y

curl -sfL https://get.k3s.io | sh -
curl -sfL https://get.k3s.io | sh -s - \
  server \
  --bind-address 0.0.0.0 \
  --node-ip $(hostname -I | awk '{print $1}') \
  --write-kubeconfig-mode 644
cat /var/lib/rancher/k3s/server/node-token > /vagrant/node-token
#sudo ufw disable
