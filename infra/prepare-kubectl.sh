#!/bin/bash

echo 'TASK[1] SETTING UP NON ROOT KUBECTL'
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo '[TASK 2] CONFIGURING CNI WITH FLANNEL'
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml