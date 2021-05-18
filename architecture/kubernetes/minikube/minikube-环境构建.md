# 下载minikube

## Binary download
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 sudo install minikube-linux-amd64 /usr/local/bin/minikube

## Debian package
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
 sudo dpkg -i minikube_latest_amd64.deb

## RPM package
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
 sudo rpm -ivh minikube-latest.x86_64.rpm



# 启动minikube(不可以用root用户登录)

## 添加当前用户到docker组
sudo usermod -aG docker $USER && newgrp docker

## 启动
minikube start