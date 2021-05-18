
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

kubectl get nodes

# 发布应用
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4

kubectl get deployments

kubectl expose deployment hello-minikube --type=NodePort --port=8080

kubectl get services hello-minikube

# 发布负载均衡
kubectl create deployment balanced --image=k8s.gcr.io/echoserver:1.4  
kubectl expose deployment balanced --type=LoadBalancer --port=8080

minikube tunnel

kubectl get services balanced



kubectl get - 列出资源
kubectl describe - 显示有关资源的详细信息
kubectl logs - 打印 pod 和其中容器的日志
kubectl exec - 在 pod 中的容器上执行命令
