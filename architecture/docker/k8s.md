
## 官网
https://kubernetes.io/  

## 中文社区
https://www.kubernetes.org.cn/  


# minikube 

## Binary download
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 sudo install minikube-linux-amd64 /usr/local/bin/minikube

## Debian package
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
 sudo dpkg -i minikube_latest_amd64.deb

## RPM package
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
 sudo rpm -ivh minikube-latest.x86_64.rpm



## Start your cluster(不可以用root用户登录)
minikube start

## 添加当前用户到docker组
sudo usermod -aG docker $USER && newgrp docker
