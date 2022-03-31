# ubuntu
docker run -itd --privileged=true --name ubuntu -p 224:22 callistoctopus/os:U18PSA-ubuntu-18.04-privileged-ssh-autostart

# ubuntu 
docker run -itd \
    --privileged=true \
    --name ubuntu \
    ubuntu:18.04 

docker exec -it ubuntu /bin/bash
apt-get -y update 
apt-get -y install --reinstall systemd
docker commit ubuntu ubuntu:tomtit
docker run -itd --privileged=true --name ubuntu -p 3399:3389 ubuntu:tomtit /sbin/init
## 若无法执行systemctl，安装systemctl后，将容器保存为镜像后重新run

# centos 
docker run -p 222:22 -p 33892:3389 -itd --privileged=true --name centos-dev centos /usr/sbin/init

# ubuntu-gnome-novnc
docker run -itd \
    -p 5901:5901 \
    --privileged=true \
    --name ubuntu \
    ubuntu:20.04 