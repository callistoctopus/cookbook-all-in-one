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

docker run --rm --name nginx-test --network host -d nginx

docker cp [containerid]:/etc/nginx/nginx.conf /home/nginx/conf/

docker stop [containerid]

docker run --rm --name nginx --network host  \
  -v /home/nginx/www:/usr/share/nginx/html \
  -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/nginx/logs:/var/log/nginx \
  -d nginx