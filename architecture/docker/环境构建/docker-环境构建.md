## Docker官网
https://www.docker.com/



* ### 安装
  https://docs.docker.com/get-docker/

$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

$ sudo yum install -y yum-utils

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

$ sudo yum install -y docker-ce docker-ce-cli containerd.io

### 设置开机启动并启动
$ sudo systemctl enable docker && systemctl start docker

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