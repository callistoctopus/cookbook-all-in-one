# 版本信息
lsb_release -a

# 查找软件
apt-cache search <softname>
apt-cache madison <sofrname>

## 软件更新 20.04
apt-get update -y
apt-get upgrade -y

## 软件安装
apt -y install *软件名称*
apt-get install unzip
apt-get install zip

# 软件卸载
apt-get -y remove firefox
apt-get -y autoremove

# 安装deb文件 
dpkg -i <package.deb>

## 解压Zip压缩文件
apt-get install unzip

unzip <文件名>
unzip vmoss.zip


# 安装xrdp
apt update \
&& apt install -y wget unzip \
&& apt install -y language-pack-zh-han* \
&& apt install -y language-pack-gnome-zh-han* \
&& apt install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
&& apt install -y xrdp \
&& service xrdp start

apt -y update \
&& apt install -y xfce4 \
&& apt install -y xrdp \
&& service xrdp start

apt -y update \
&& apt install -y gnome \
&& apt install -y xrdp \
&& service xrdp start

# 安装防火墙
apt-get install ufw

# ifconfig
apt install net-tools

# ping 
apt install iputils-ping

# 安装 java
apt -y install openjdk-11-jdk

# 允许远程登录
（1）检查是否开启SSH服务 
　　命令：ps -e|grep ssh  查看SSH服务是否开启，或者通过命令：service sshd status 可以查看某个服务的状态。

（2）安装SSH服务
 　  通过apt-get 安装，命令：apt-get install ssh 

（3）启动SSH服务
　  命令：sudo /etc/init.d/ssh start

（4）修改SSH配置文件
 　命令：sudo vim /etc/ssh/sshd_config，找到PermitRootLogin without-password 修改为PermitRootLogin yes

（5）重启SSH服务
　命令：service ssh restart

# 安装Mysql客户端
apt-get install -y mysql-client

# 安装Mysql
apt-get install -y mysql-server
mysql_secure_installation
systemctl status mysql.service

# 安装systemctl 
apt-get -y install --reinstall systemd
