#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
sudo apt-get update -y
#sudo apt-get upgrade -y
sudo apt-get install vim curl -y

curl -sfL https://get.k3s.io | K3S_URL="$URL" K3S_TOKEN="$TOKEN" sh -
#sudo ufw disable
