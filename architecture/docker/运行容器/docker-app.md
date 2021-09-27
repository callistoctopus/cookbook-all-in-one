# unbuntu 
docker run -itd --privileged=true --name ubuntu ubuntu:18.04 
docker exec -it ubuntu /bin/bash
apt-get -y update 
apt-get -y install --reinstall systemd
docker commit ubuntu ubuntu:tomtit
docker run -itd --privileged=true --name ubuntu -p 3399:3389 ubuntu:tomtit /sbin/init
## 若无法执行systemctl，安装systemctl后，将容器保存为镜像后重新run

# centos 
docker run -p 222:22 -p 33892:3389 -itd --privileged=true --name centos-dev centos /usr/sbin/init

# kasmweb desktop
docker pull kasmweb/desktop:1.9.0
docker run -itd --shm-size=512m -p 6901:6901 -u root -e VNC_PW=password kasmweb/desktop:1.9.0
https://<ip>:6901/
User : kasm_user
Password: password

# kasmweb desktop-deluxe
docker pull kasmweb/desktop-deluxe:1.7.0-edge
docker run -itd --shm-size=512m -p 6901:6901 -u root -e VNC_PW=password kasmweb/desktop-deluxe:1.9.0
https://<ip>:6901/
User : kasm_user
Password: password

# ubuntu-desktop-lxde-vnc
docker run -itd -p 6080:80 -p 5900:5900  -e RESOLUTION=1920x1080 -e VNC_PASSWORD=password dorowu/ubuntu-desktop-lxde-vnc

# docker-ubuntu-xrdp-mate-custom
echo "user:pass:Y" > CREATEUSERS.TXT
docker run --name RattyDAVE20.04 \
           --privileged=true \
           -p 3389:3389 \
           -e TZ="Europe/London" \
           -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt \
           -dit --restart unless-stopped \
           rattydave/docker-ubuntu-xrdp-mate-custom:20.04

# mysql

docker pull mysql:5.7   # 拉取 mysql 5.7
docker pull mysql       # 拉取最新版mysql镜像

docker run -p 3306:3306 --restart=on-failure --name mysql -e MYSQL_ROOT_PASSWORD=toor -d mysql:5.7
–name：容器名，此处命名为mysql
-e：配置信息，此处配置mysql的root用户的登陆密码
-p：端口映射，此处映射 主机3306端口 到 容器的3306端口
-d：后台运行容器，保证在退出终端后容器继续运行

docker exec -it mysql bash

# mongo
docker run --name mongo --restart=on-failure -p 27017:27017 -d mongo --auth

docker exec -it mongo /bin/bash

mongo
use admin
db.createUser({user:"root",pwd:"toor",roles:[{role:'root',db:'admin'}]})   //创建用户,此用户创建成功,则后续操作都需要用户认证
exit

# rabbit
docker pull rabbitmq:management
docker run -d --name rabbit --restart=on-failure -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=toor rabbitmq:management
http://<hostname>:15672

# postgre
docker pull postgres
docker run --name postgre -p 5432:5432 --restart=on-failure -e POSTGRES_PASSWORD=toor -d postgres

# redis
docker pull redis
docker run -itd --name redis --restart=on-failure -p 6379:6379 redis --requirepass "toor"

# openjdk
docker pull openjdk

# nginx
mkdir -p /home/nginx/www /home/nginx/logs /home/nginx/conf

//获取nginx.conf(可省略)
docker run --rm --name nginx-test --network host -d nginx

docker cp [containerid]:/etc/nginx/nginx.conf /home/nginx/conf/

docker stop [containerid]
//获取nginx.conf

docker run --rm --name nginx --network host  \
  -v /home/nginx/www:/usr/share/nginx/html \
  -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/nginx/logs:/var/log/nginx \
  -d nginx

# busybox
docker run -it --rm busybox
docker run -itd --name busybox busybox
docker exec -it c68150755368 /bin/sh

# mono

# gcc
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 gcc -o myapp myapp.c
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 make

# node
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/app -w /usr/src/app node:8 node your-daemon-or-script.js

<dockerfile>
FROM node:10
EXPOSE 8888

docker build -t my-nodejs-app .
docker run -it --rm --name my-running-app my-nodejs-app

# python
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:3 python your-daemon-or-script.py

<dockerfile>
FROM python:3
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python", "./your-daemon-or-script.py" ]

docker build -t my-python-app .
docker run -it --rm --name my-running-app my-python-app

# golang
docker run -itd --name golang golang:1.16 /bin/bash
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.16 go build main.go

# ruby
## Generate a Gemfile.lock
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install

## Run a single Ruby script
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby:2.5 ruby your-daemon-or-script.rb

<dockerfile>
FROM ruby:2.5
RUN bundle config --global frozen 1
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
CMD ["./your-daemon-or-script.rb"]

docker build -t my-ruby-app .
docker run -it --name my-running-script my-ruby-app

# bash
docker run -it --rm -v /path/to/script.sh:/script.sh:ro bash:4.4 bash /script.sh

<dockerfile>
FROM bash:4.4
COPY script.sh /
CMD ["bash", "/script.sh"]

docker build -t my-bash-app .
docker run -it --rm --name my-running-app my-bash-app

# java
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:7 javac Main.java

<dockerfile>
FROM openjdk:7
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java
CMD ["java", "Main"]

docker build -t my-java-app .
docker run -it --rm --name my-running-app my-java-app

# vpn

docker run \
    --name ipsec-vpn-server \
    --restart=always \
    -v ikev2-vpn-data:/etc/ipsec.d \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -d --privileged \
    hwdsl2/ipsec-vpn-server

docker logs ipsec-vpn-server

Windows 10 and 8.x
右键单击系统托盘中的无线/网络图标。
选择 打开网络和共享中心。或者，如果你使用 Windows 10 版本 1709 或以上，选择 打开"网络和 Internet"设置，然后在打开的页面中单击 网络和共享中心。
单击 设置新的连接或网络。
选择 连接到工作区，然后单击 下一步。
单击 使用我的Internet连接 (VPN)。
在 Internet地址 字段中输入你的 VPN 服务器 IP。
在 目标名称 字段中输入任意内容。单击 创建。
返回 网络和共享中心。单击左侧的 更改适配器设置。
右键单击新创建的 VPN 连接，并选择 属性。
单击 安全 选项卡，从 VPN 类型 下拉菜单中选择 "使用 IPsec 的第 2 层隧道协议 (L2TP/IPSec)"。
单击 允许使用这些协议。选中 "质询握手身份验证协议 (CHAP)" 和 "Microsoft CHAP 版本 2 (MS-CHAP v2)" 复选框。
单击 高级设置 按钮。
单击 使用预共享密钥作身份验证 并在 密钥 字段中输入你的 VPN IPsec PSK。
单击 确定 关闭 高级设置。
单击 确定 保存 VPN 连接的详细信息。

注： 在首次连接之前需要修改一次注册表，以解决 VPN 服务器 和/或 客户端与 NAT （比如家用路由器）的兼容问题。
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f
完成后必须重启计算机。

如果你使用 Windows 10 并且 VPN 卡在 "正在连接" 状态超过几分钟，尝试以下步骤：

右键单击系统托盘中的无线/网络图标。
选择 打开"网络和 Internet"设置，然后在打开的页面中单击左侧的 VPN。
选择新的 VPN 连接，然后单击 连接。如果出现提示，在登录窗口中输入 你的 VPN 用户名 和 密码 ，并单击 确定。

# jenkins
docker run -itd -p 8080:8080 -p 50000:50000 -v /root/jenkins:/var/jenkins_home jenkins/jenkins

# gitlab
docker run -d  -p 8443:443 -p 8081:80 -p 223:22 --name gitlab --restart always -v /home/gitlab/config:/etc/gitlab -v /home/gitlab/logs:/var/log/gitlab -v /home/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce
