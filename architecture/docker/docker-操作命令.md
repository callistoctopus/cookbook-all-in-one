# 常用命令

# 查看docker状态
docker info

# 切换docker context
docker context create <context name> --docker "host=ssh://<user>@<host>"
docker context use <context name>

# windows openssl ssh
PowerShell 窗口里面运行 （administrator 模式）:

ssh-keygen

把这个id_rsa.pub 传送到远程主机，复制成文件： ~/.ssh/authorized_keys
如果远程主机上这个authorized_keys已经存在，就添加到后面
cat id_rsa.pub >> ~/.ssh/authorized_keys

Set-Service ssh-agent -StartupType "Automatic"
Start-Service ssh-agent

ssh-add ~/.ssh/id_rsa

测试一下，无需密码直接ssh连接到远程主机:

ssh <user>@<host>

# 查看docker硬盘状态
docker system df

# 清理docker硬盘（会删除已停止的容器）
docker system prune
docker container prune # 删除所有退出状态的容器
docker volume prune # 删除未被使用的数据卷
docker image prune # 删除 dangling 或所有未被使用的镜像

# 修改容器镜像存贮空间大小
systemctl stop docker

vim /usr/lib/systemd/system/docker.service
在 ExecStart=/usr/bin/dockerd 后面添加 --storage-driver devicemapper --storage-opt dm.loopdatasize=35G --storage-opt dm.loopmetadatasize=10G --storage-opt dm.fs=ext4 --storage-opt dm.basesize=20G

systemctl daemon-reload

systemctl start docker


# 登录私有仓库
sudo docker login --username=auste**** registry.cn-hangzhou.aliyuncs.com

# 镜像操作
## 列出本地主机上的镜像
docker images 

## 查找镜像
docker search httpd

## 获取一个新的镜像
docker pull ubuntu:13.10

## 删除镜像
docker rmi hello-world

## 导出镜像
docker save <镜像 id> > ubuntu.tar

## 导入镜像
docker load < ubuntu.tar

## 设置镜像标签
docker tag 860c279d2fec runoob/centos:dev
docker tag 镜像ID，这里是 860c279d2fec ,用户名称、镜像源名(repository name)和新的标签名(tag)。

## 向自己的私有仓库上传镜像
docker push 10.24.2.30:5000/nginx:latest  

## 从已经创建的容器中更新镜像，并且提交这个镜像
docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2
-m: 提交的描述信息
-a: 指定镜像作者
e218edb10161：容器 ID
runoob/ubuntu:v2: 指定要创建的目标镜像名

## 重新构建一个镜像
docker build -t runoob/centos:6.7 .
-t ：指定要创建的目标镜像名
. ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径

# 容器操作

## 拷贝文件
docker cp <containerid>:<path> <containerid>:<path>

## 启动容器
docker run -it --restart=on-failure ubuntu /bin/bash
-i: 交互式操作。
-t: 终端。
--restart:重启策略 no，默认策略 on-failure，在容器非正常退出时（退出状态非0），才会重启容器， on-failure:3，在容器非正常退出时重启容器，最多重启3次 always，在容器退出时总是重启容器
ubuntu: ubuntu 镜像。
/bin/bash：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash。
通过 -p 参数来设置不一样的端口
-v:路径映射 <host/path>:<container/path>

## 退出终端
exit

## 后台运行
docker run -itd --name ubuntu-test ubuntu /bin/bash

## 停止一个容器
docker stop <容器 ID>

## 删除一个容器
docker rm -f 1e560fca3906

## 重启停止的容器
docker restart <容器 ID> 

## 查看所有的容器
docker ps -a

## 启动一个已停止的容器
docker start b750bbbcfd88 

## 进入容器
docker attach 1e560fca3906 
docker exec -it 243c32535da7 /bin/bash：推荐大家使用 docker exec 命令，因为此退出容器终端，不会导致容器的停止。

## 导出容器
docker export 1e560fca3906 > ubuntu.tar

## 导入容器快照
cat docker/ubuntu.tar | docker import - test/ubuntu:v1
或者
docker import http://example.com/exampleimage.tgz example/imagerepo

## 构建镜像
docker build -t nginx:v3 .
注：最后的 . 代表本次执行的上下文路径

## 查看到容器的端口映射
docker port bf08b7f2cd89

## 查看容器内部的标准输出
docker logs -f bf08b7f2cd89

# 查看容器内存及CPU使用情况
docker stats contrainer id

## 查看容器内部运行的进程
docker top wizardly_chandrasekhar

## 查看 Docker 的底层信息
docker inspect wizardly_chandrasekhar


# docker 网络
## 查看网络
docker network ls

## 创建网络
docker network create my_net

## 删除网络
docker network rm my_net

## 指定网络
--network my_net 

## 指定网络别名
--network-alias php