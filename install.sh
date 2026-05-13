#!/bin/sh

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt
sudo apt-get update && \
    sudo apt-get install -y qemu libvirt-daemon-system ebtables libguestfs-tools \
        vagrant ruby-fog-libvirt
sudo apt-get install qemu-system

vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-env

