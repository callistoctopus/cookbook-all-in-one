# kubectl 语法

# kubectl [command] [TYPE] [NAME] [flags]

其中 command、TYPE、NAME 和 flags 分别是：

command：指定要对一个或多个资源执行的操作，例如 create、get、describe、delete。

TYPE：指定资源类型。资源类型不区分大小写， 可以指定单数、复数或缩写形式。例如，以下命令输出相同的结果:

    kubectl get pod pod1
    kubectl get pods pod1
    kubectl get po pod1

NAME：指定资源的名称。名称区分大小写。 如果省略名称，则显示所有资源的详细信息 kubectl get pods。

    在对多个资源执行操作时，你可以按类型和名称指定每个资源，或指定一个或多个文件：

    要按类型和名称指定资源：

    要对所有类型相同的资源进行分组，请执行以下操作：TYPE1 name1 name2 name<#>。

    例子：kubectl get pod example-pod1 example-pod2

    分别指定多个资源类型：TYPE1/name1 TYPE1/name2 TYPE2/name3 TYPE<#>/name<#>。

    例子：kubectl get pod/example-pod1 replicationcontroller/example-rc1

    用一个或多个文件指定资源：-f file1 -f file2 -f file<#>

    使用 YAML 而不是 JSON 因为 YAML 更容易使用，特别是用于配置文件时。 例子：kubectl get -f ./pod.yaml

flags: 指定可选的参数。例如，可以使用 -s 或 -server 参数指定 Kubernetes API 服务器的地址和端口。


# 常用操作

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
kubectl logs POD [-c CONTAINER] [--follow] [flags]




# 在容器之间复制文件和目录。
kubectl cp <file-spec-src> <file-spec-dest> [options]

# 对 pod 中的容器执行命令。
kubectl exec POD [-c CONTAINER] [-i] [-t] [flags] [-- COMMAND [args...]]

# 将副本控制器、服务或 pod 作为新的 Kubernetes 服务暴露。
kubectl expose (-f FILENAME | TYPE NAME | TYPE/NAME) [--port=port] [--protocol=TCP|UDP] [--target-port=number-or-name] [--name=name] [--external-ip=external-ip-of-service] [--type=type] [flags]

# 全局命令行选项列表，适用于所有命令。
kubectl options

# 将一个或多个本地端口转发到一个 pod。
kubectl port-forward POD [LOCAL_PORT:]REMOTE_PORT [...[LOCAL_PORT_N:]REMOTE_PORT_N] [flags]
# 将本地的7080转发到hello-minikube的8080
kubectl port-forward service/hello-minikube 7080:8080 

# 运行 Kubernetes API 服务器的代理。
kubectl proxy [--port=PORT] [--www=static-dir] [--www-prefix=prefix] [--api-prefix=prefix] [flags]
kubectl proxy --port=33567 --address='192.168.0.191' --accept-hosts='^.*' &

# 管理资源的部署。有效的资源类型包括：Deployments, DaemonSets 和 StatefulSets。
kubectl rollout SUBCOMMAND [options]

# 在集群上运行指定的镜像。
kubectl run NAME --image=image [--env="key=value"] [--port=port] [--dry-run=server | client | none] [--overrides=inline-json] [flags]

# 更新指定副本控制器的大小。
kubectl scale (-f FILENAME | TYPE NAME | TYPE/NAME) --replicas=COUNT [--resource-version=version] [--current-replicas=count] [flags]

# 标签可以附加到任何Kubemetes对象上， 包括节点。
kubectl label node k8s.node1 type=vmware

# 修改现有pod的标签
kubectl label po my-first-app app=test2 --overwrite



# 输出选项

# kubectl [command] [TYPE] [NAME] -o=<output_format>
-o custom-columns=<spec>	使用逗号分隔的自定义列列表打印表。
-o custom-columns-file=<filename>	使用 <filename> 文件中的自定义列模板打印表。
-o json	输出 JSON 格式的 API 对象
-o jsonpath=<template>	打印 jsonpath 表达式定义的字段
-o jsonpath-file=<filename>	打印 <filename> 文件中 jsonpath 表达式定义的字段。
-o name	仅打印资源名称而不打印任何其他内容。
-o wide	以纯文本格式输出，包含任何附加信息。对于 pod 包含节点名。
-o yaml	输出 YAML 格式的 API 对象。








