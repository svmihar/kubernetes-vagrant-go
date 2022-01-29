#!/bin/bash
echo 'TASK[1] BERSIH-BERSIH DULU'
apt-get update >/dev/null 2>&1
apt-mark hold package grub-pc grub-pc-bin grub2-common grub-common >/dev/null 2>&1
apt-get dist-upgrade -y >/dev/null 2>&1
# END PRE

echo 'TASK[2] INSTALLING DOCKER'
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common >/dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null 2>&1
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update >/dev/null 2>&1
apt-get install -y \
  containerd.io=1.4.6-1 \
  docker-ce=5:20.10.7~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:20.10.7~3-0~ubuntu-$(lsb_release -cs) >/dev/null 2>&1
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload >/dev/null 2>&1
systemctl start docker >/dev/null 2>&1
systemctl enable docker >/dev/null 2>&1
apt-mark hold docker-ce >/dev/null 2>&1
# END DOCKER

echo 'TASK[3] INSTALLING KUBELET KUBEADM KUBECTL' 
apt-get install -y apt-transport-https curl >/dev/null 2>&1
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg >/dev/null 2>&1
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update >/dev/null 2>&1 
apt-get install -y kubelet=1.21.2-00 kubeadm=1.21.2-00 kubectl=1.21.2-00 >/dev/null 2>&1 
apt-mark hold kubelet kubeadm kubectl >/dev/null 2>&1
#END KUBE


echo 'TASK[4] TURNING OFF SWAP' 
swapoff -a
sed -i '/swap/d' /etc/fstab
#END SWAP


echo 'TASK[5] CLEANING...' 
apt-get clean >/dev/null 2>&1
cat /dev/null > ~/.bash_history && history -c && exit
# end post