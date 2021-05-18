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

kubectl port-forward service/hello-minikube 7080:8080

kubectl proxy --port=33567 --address='192.168.0.191' --accept-hosts='^.*' &


kubectl get - 列出资源
kubectl describe - 显示有关资源的详细信息
kubectl logs - 打印 pod 和其中容器的日志
kubectl exec - 在 pod 中的容器上执行命令