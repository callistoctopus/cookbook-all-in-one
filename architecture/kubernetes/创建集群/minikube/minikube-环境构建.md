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



# 在 Linux 系统中安装 kubectl 
## 下载最新发行版
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

## 安装 kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## 测试
kubectl version --client

kubectl cluster-info

# 安装Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh