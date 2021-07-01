# 安装kubeadm

前提: CPU 2
     RAM 2G 

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

5. 设置主机名

6. 在Yum仓库中添加Kubernetes

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
9.  kubeadm初始化镜像无法下载
    查看需要的镜像
    kubeadm config images list
   使用国内云计算厂商都提供了kubernetes的镜像服务
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.14.0
   将下载后的镜像打上tag，来符合kudeadm init初始化时候的要求
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.14.0  k8s.gcr.io/kube-apiserver:v1.14.0

   注：k8s.gcr.io/coredns/coredns:v1.8.0镜像为registry.aliyuncs.com/google_containers/coredns:1.8.0

    注：

    主节点：

    k8s.gcr.io/kube-apiserver:v1.21.1
    k8s.gcr.io/kube-controller-manager:v1.21.1
    k8s.gcr.io/kube-scheduler:v1.21.1
    k8s.gcr.io/kube-proxy:v1.21.1
    k8s.gcr.io/pause:3.4.1
    k8s.gcr.io/etcd:3.4.13-0
    k8s.gcr.io/coredns/coredns:v1.8.0
    子节点：

    k8s.gcr.io/kube-proxy:v1.21.1
    k8s.gcr.io/pause:3.4.1
    k8s.gcr.io/etcd:3.4.13-0
    k8s.gcr.io/coredns/coredns:v1.8.0


10.  搭建控制平面节点 （仅主节点）
    
     kubeadm init 

11.  安装weave网络插件 （仅主节点）

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

1.   export KUBECONFIG=/etc/kubernetes/admin.conf （仅主节点）
2.   kubectl get nodes （仅主节点）


3.   子节点加入集群  （仅子节点）
kubeadm join 192.168.110.220:6443 --token fk77w6.m2r11paj2sst1ezg --discovery-token-ca-cert-hash sha256:7ae6944565d8c8468e55c65cb8b5e3a4fa5b315b551b153741a45b8ff5c0b793


