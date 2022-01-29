#!/bin/bash

echo '[TASK 1] CONFIGURING KUBERNETES VIA KUBEADM'
kubeadm init --apiserver-advertise-address=$NODE_IP --pod-network-cidr=10.0.0.0/16 >/dev/null 2>&1

echo '[TASK 2] CONFIGURING HOSTS FILE'
sed "s/127.0.0.1.*m/$NODE_IP m/" -i /etc/hosts

echo '[TASK 3] WRITING TOKEN TO FILE'
rm -rf /vagrant/join.sh
kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x /vagrant/join.sh

# echo '[TASK 4] DEPLOYING KUBE DASHBOARD'
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml