
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




# 安装kubeadm

1. 禁用SELinux
2. 禁用防火墙
3. 禁用交换分区
   swapoff -a
   vi /etc/fstab
   #/mnt/swap swap swap defaults 0 0
   free -m
   echo 0 > /proc/sys/vm/swappiness
   vi /etc/sysctl.conf 
   vm.swappiness=0
   sysctl -p
4. 允许 iptables 检查桥接流量
    cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
    br_netfilter
    EOF

    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
    net.bridge.bridge-nf-call-ip6tables = 1
    net.bridge.bridge-nf-call-iptables = 1
    EOF

    sysctl --system
5. 在Yum仓库中添加Kubernetes
    cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
    exclude=kubelet kubeadm kubectl
    EOF
6. 安装启用Docker
7. sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
8. systemctl enable --now kubelet
9. kubeadm初始化镜像无法下载
    查看需要的镜像
    kubeadm config images list
   使用国内云计算厂商都提供了kubernetes的镜像服务
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.14.0
   将下载后的镜像打上tag，来符合kudeadm init初始化时候的要求
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.14.0  k8s.gcr.io/kube-apiserver:v1.14.0

   注：k8s.gcr.io/coredns/coredns:v1.8.0镜像为registry.aliyuncs.com/google_containers/coredns:1.8.0

10. kubeadmin init 


