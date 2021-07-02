# 安装 RabbitMQ Cluster Operator
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"

# Hello RabbitMQ!
kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml
kubectl apply -f rabbitmq.rabbitmq.yml

# 访问管理界面
username="$(kubectl get secret custom-configuration-default-user -o jsonpath='{.data.username}' | base64 --decode)"

echo "username: $username"

password="$(kubectl get secret custom-configuration-default-user -o jsonpath='{.data.password}' | base64 --decode)"

echo "password: $password"

kubectl port-forward "service/custom-configuration" 15672

# 连接一个应用到集群
username="$(kubectl get secret custom-configuration-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret custom-configuration-default-user -o jsonpath='{.data.password}' | base64 --decode)"
service="$(kubectl get service custom-configuration -o jsonpath='{.spec.clusterIP}')"

kubectl run perf-test-1 --image=pivotalrabbitmq/perf-test -- --uri amqp://$username:$password@$service
kubectl run perf-test-2 --image=pivotalrabbitmq/perf-test -- --uri amqp://$username:$password@$service
kubectl run perf-test-3 --image=pivotalrabbitmq/perf-test -- --uri amqp://$username:$password@$service