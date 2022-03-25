# postgres 11
docker run -d -e POSTGRES_USER=user -e POSTGRES_PASSWORD=pass -p 5432:5432 --name postgre11 postgres:11

# postgres 13
docker run -d -e POSTGRES_USER=user -e POSTGRES_PASSWORD=pass -p 5432:5432 --name postgre13 postgres:13

# mysql 5.7
docker run -d -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_ROOT_PASSWORD=pass -p 3306:3306 --name mysql5.7 mysql:5.7

# mysql 8
## 方法一：
docker run -d \
     -e MYSQL_ROOT_PASSWORD=pass \
     -p 3306:3306 \
     --name mysql8 \
     mysql:8

create user 'user'@'%' identified with mysql_native_password by 'pass';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
FLUSH PRIVILEGES;

## 方法二：
docker run -itd --privileged=true --name mysql8 -p 3306:3306 registry.cn-hangzhou.aliyuncs.com/keiki/server:U18PSAMY8-u18psa-mysql8.0.27
(user,pass)(root,toor)

# tomcat 8.5
docker run -itd --privileged=true --name tomcat -p 220:22 -p 80:8080 registry.cn-hangzhou.aliyuncs.com/keiki/server:U18PSAJ11T85-u18psa-java11-tomcat8.5

docker run -itd --privileged=true --name tomcat -p 220:22 -p 80:8080 callistoctopus/server:U18PSAJ11T85-u18psa-java11-tomcat8.5
docker cp tomcat:/usr/local/apache-tomcat-8.5.72 /var/work/volumes

docker run -itd --rm --privileged=true --name tomcat \
     -p 228:22 -p 80:8080 \
     -v /var/work/volumes/config/apache-tomcat-8.5.72/conf:/usr/local/apache-tomcat-8.5.72/conf \
     -v /var/work/projects/client/mobile/browser/html/app:/usr/local/apache-tomcat-8.5.72/webapps/app \
     callistoctopus/server:U18PSAJ11T85-u18psa-java11-tomcat8.5

docker run -itd \
     --rm \
     -p 80:8080 \
     -v /var/work/volumes/config/tomcat-9.0/conf:/usr/local/tomcat/conf \
     -v /var/work/volumes/config/tomcat-9.0/webapps:/usr/local/tomcat/webapps \
     --name tomcat9 \
     tomcat:9.0

# nginx
## 方法一
docker run -itd \
     --rm --privileged=true \
     -p 444:443 \
     -v /var/work/volumes/config/nginx-1.20.2:/etc/nginx \
     --name nginx \
     nginx:1.20.2

docker run -itd \
     --rm --privileged=true \
     --name nginx \
     -p 444:443 \
     -p 6061:6061 \
     -v /var/work/volumes/config/nginx:/etc/nginx \
     callistoctopus/server:U18PSAN-u18psa-nginx

## 方法二
mkdir -p /home/nginx/www /home/nginx/logs /home/nginx/conf

//获取nginx.conf(可省略)
docker run --rm --name nginx-test -d nginx

docker cp [containerid]:/etc/nginx/nginx.conf /home/nginx/conf/

docker stop [containerid]
//获取nginx.conf

docker run --name nginx \
  -v /home/nginx/www:/usr/share/nginx/html \
  -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/nginx/logs:/var/log/nginx \
  -d nginx

# mongo
docker run --name mongo --restart=on-failure -p 27017:27017 -d mongo --auth

docker exec -it mongo /bin/bash

mongo
use admin
db.createUser({user:"root",pwd:"toor",roles:[{role:'root',db:'admin'}]})   //创建用户,此用户创建成功,则后续操作都需要用户认证
exit

# redis
docker pull redis
docker run -itd --name redis --restart=on-failure -p 6379:6379 redis --requirepass "toor"

# vpn
docker run \
     --name vpn \
     -e VPN_IPSEC_PSK=z7q9ihayuJhNJn7NVYmf \
     -e VPN_USER=vpnuser \
     -e VPN_PASSWORD=b2KBjGm4kZK8SkAh \
     --restart=always \
     -v ikev2-vpn-data:/etc/ipsec.d \
     -p 500:500/udp \
     -p 4500:4500/udp \
     -d \
     --privileged \
     hwdsl2/ipsec-vpn-server

docker logs ipsec-vpn-server

# rabbitmq
docker run -d \
     --hostname my-rabbit \
     --name rabbit \
     -p 5672:5672 \
     -p 15672:15672 \
     -e RABBITMQ_DEFAULT_USER=user \
     -e RABBITMQ_DEFAULT_PASS=password \
     -v /var/work/volumes/config/rabbitmq/enabled_plugins:/etc/rabbitmq/enabled_plugins \
     rabbitmq:3-management

# rtmp 
docker run -d \
     -p 1935:1935 \
     -p 8080:8080 \
     --name rtmp
     alqutami/rtmp-hls

http://localhost:8080/players/hls.html
http://localhost:8080/players/hls_hlsjs.html





