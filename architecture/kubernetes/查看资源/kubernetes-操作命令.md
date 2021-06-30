# 显示运行在客户端和服务器上的 Kubernetes 版本。
kubectl version [--client] [flags]

# 列出可用的 API 资源。
kubectl api-resources

# 列出可用的 API 版本。
kubectl api-versions

# 显示有关集群中主服务器和服务的端口信息。
kubectl cluster-info

# 显示一个或多个资源的详细状态。
kubectl describe (-f FILENAME | TYPE [NAME_PREFIX | /NAME | -l label]) [flags]

# 列出一个或多个资源。
kubectl get (-f FILENAME | TYPE [NAME | /NAME | -l label]) [--watch] [--sort-by=FIELD] [[-o | --output]=OUTPUT_FORMAT] [flags]

kubectl get nodes
kubectl get pods -l app=test
kubectl get deployments
kubectl get services hello-minikube

# 显示资源（CPU/内存/存储）的使用情况。
kubectl top [flags] [options]

# 在 pod 中打印容器的日志。
kubectl logs [POD] [-c CONTAINER] [--follow] [flags]