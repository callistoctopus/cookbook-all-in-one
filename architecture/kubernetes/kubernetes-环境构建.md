
## 官网
https://kubernetes.io/  

## 中文社区
https://www.kubernetes.org.cn/  


# 在 Linux 系统中安装 kubectl 
## 下载最新发行版
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

## 安装 kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## 测试
kubectl version --client

kubectl cluster-info



