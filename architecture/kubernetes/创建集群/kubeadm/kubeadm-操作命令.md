# Kubernetes 生成 Join Token 并显示
kubeadm token create --print-join-command
这样生成的 Token 有效期是 24 小时，如果不想过期，可以加上 --ttl=0 这个参数

# 查看token
kubeadm token list

# 设置主节点是否可被调度
kubectl taint nodes [nodename] node-role.kubernetes.io/master-

kubectl taint nodes [nodename] node-role.kubernetes.io/master=:NoSchedule