# unbuntu 
docker run -itd --privileged=true --name ubuntu -p 3399:3389 ubuntu:18.04

# centos 
docker run -p 222:22 -p 33892:3389 -itd --privileged=true --name centos-dev centos /sbin/init

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

## dockerfile
FROM node:10
EXPOSE 8888

docker build -t my-nodejs-app .
docker run -it --rm --name my-running-app my-nodejs-app

# python
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:3 python your-daemon-or-script.py

## dockerfile
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

## dockerfile
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

## dockerfile
FROM bash:4.4
COPY script.sh /
CMD ["bash", "/script.sh"]

docker build -t my-bash-app .
docker run -it --rm --name my-running-app my-bash-app

# java
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:7 javac Main.java

## dockerfile
FROM openjdk:7
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java
CMD ["java", "Main"]

docker build -t my-java-app .
docker run -it --rm --name my-running-app my-java-app
