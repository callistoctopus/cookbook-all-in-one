# Kubernetes 生成 Join Token 并显示
kubeadm token create --print-join-command
这样生成的 Token 有效期是 24 小时，如果不想过期，可以加上 --ttl=0 这个参数

# 查看token
kubeadm token list

# 设置主节点是否可被调度
kubectl taint nodes [nodename] node-role.kubernetes.io/master-

kubectl taint nodes [nodename] node-role.kubernetes.io/master=:NoSchedule


# 驱逐node上的pod
kubectl drain node06 --delete-local-data --force --ignore-daemonsets

# 删除node
kubectl delete nodes node06

# 重置节点
kubeadm reset
systemctl stop kubelet
systemctl stop docker

rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/

ifconfig cni0 down
ifconfig flannel.1 down
ifconfig docker0 down

ip link delete cni0
ip link delete flannel.1

systemctl start docker
systemctl start kubelet