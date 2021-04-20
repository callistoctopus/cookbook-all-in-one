## Docker官网
https://www.docker.com/



* ### 安装
  https://docs.docker.com/get-docker/

# 注

# 官方源（较慢）
$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# 阿里云
$ sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 清华大学源
$ sudo yum-config-manager \
    --add-repo \
    https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo



### 启动
$ sudo systemctl start docker


## Docker Hub 官网
https://hub.docker.com/  



## 阿里云镜像加速器
阿里云->容器镜像服务->镜像工具->镜像加速器

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://sxj4w1qf.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker


# Docker 代理
mkdir /etc/systemd/system/docker.service.d
cat >/etc/systemd/system/docker.service.d/http_proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=http://192.168.1.1:80/"       #代理服务器地址
Environment="HTTPS_PROXY=http://192.168.1.1:80/"     #https
Environment="NO_PROXY=localhost,127.0.0.0/8,docker-registry.somecorporation.com"    #哪些地址不需要走代理
EOF
systemctl daemon-reload
systemctl restart docker



# 常用命令

# 镜像操作
列出本地主机上的镜像
docker images 

查找镜像
docker search httpd

获取一个新的镜像
docker pull ubuntu:13.10

删除镜像
docker rmi hello-world

设置镜像标签
docker tag 860c279d2fec runoob/centos:dev
docker tag 镜像ID，这里是 860c279d2fec ,用户名称、镜像源名(repository name)和新的标签名(tag)。

从已经创建的容器中更新镜像，并且提交这个镜像
docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2
-m: 提交的描述信息
-a: 指定镜像作者
e218edb10161：容器 ID
runoob/ubuntu:v2: 指定要创建的目标镜像名

重新构建一个镜像
docker build -t runoob/centos:6.7 .
-t ：指定要创建的目标镜像名
. ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径

# 容器操作

启动容器
docker run -it ubuntu /bin/bash
-i: 交互式操作。
-t: 终端。
ubuntu: ubuntu 镜像。
/bin/bash：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash。
通过 -p 参数来设置不一样的端口

退出终端
exit

后台运行
docker run -itd --name ubuntu-test ubuntu /bin/bash

停止一个容器
docker stop <容器 ID>

删除一个容器
docker rm -f 1e560fca3906

重启停止的容器
docker restart <容器 ID> 

查看所有的容器
docker ps -a

启动一个已停止的容器
docker start b750bbbcfd88 

进入容器
docker attach 1e560fca3906 
docker exec -it 243c32535da7 /bin/bash：推荐大家使用 docker exec 命令，因为此退出容器终端，不会导致容器的停止。

导出容器
docker export 1e560fca3906 > ubuntu.tar

导入容器快照
cat docker/ubuntu.tar | docker import - test/ubuntu:v1
或者
docker import http://example.com/exampleimage.tgz example/imagerepo

查看到容器的端口映射
docker port bf08b7f2cd89

查看容器内部的标准输出
docker logs -f bf08b7f2cd89

查看容器内部运行的进程
docker top wizardly_chandrasekhar

查看 Docker 的底层信息
docker inspect wizardly_chandrasekhar