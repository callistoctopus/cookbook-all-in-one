
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



# 在 Linux 系统中安装 kubectl 
## 下载最新发行版
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

## 安装 kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## 测试
kubectl version --client

# 发布应用
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-minikube --type=NodePort --port=8080

kubectl get services hello-minikube

# 发布负载均衡
kubectl create deployment balanced --image=k8s.gcr.io/echoserver:1.4  
kubectl expose deployment balanced --type=LoadBalancer --port=8080

minikube tunnel

kubectl get services balanced




minikube pause

minikube stop

minikube config set memory 16384

minikube addons list

minikube delete --all
