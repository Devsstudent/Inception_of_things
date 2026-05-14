#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
sudo apt-get update -y
#sudo apt-get upgrade -y
sudo apt-get install vim curl -y
source .env
cp /etc/environment /etc/systemd/system/k3s.service.env
curl -sfL https://get.k3s.io | sh -s - agent --server https://192.168.56.110:6443 --token inception 
#sudo ufw disable
