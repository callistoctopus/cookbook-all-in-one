# 从文件或 stdin 创建一个或多个资源。
kubectl create -f FILENAME [flags]

# 从文件或 stdin 对资源应用配置更改。
kubectl apply -f FILENAME [flags]

# 从文件、标准输入或指定标签选择器、名称、资源选择器或资源中删除资源。
kubectl delete (-f FILENAME | TYPE [NAME | /NAME | -l label | --all]) [flags]

# 通过命令行创建应用
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4

# 创建密码
kubectl create secret docker-registry registry-secret-aliyun --docker-server=registry.cn-beijing.aliyuncs.com --docker-username=xxxxxxx@qq.com --docker-password=xxxxxxx
