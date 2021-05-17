kubectl port-forward service/hello-minikube 7080:8080

kubectl proxy --port=33567 --address='192.168.0.191' --accept-hosts='^.*' &