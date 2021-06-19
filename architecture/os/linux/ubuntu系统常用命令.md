# 版本信息
lsb_release -a


## 软件更新 20.04
**apt-get update**

## 软件安装
**apt -y install** *软件名称*
```
apt-get install unzip
apt-get install zip
```

# 安装deb文件 
dpkg -i <package.deb>

## 解压Zip压缩文件
```
apt-get install unzip
```
**unzip** *文件名*
```
unzip vmoss.zip
```

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

# ifconfig
apt install net-tools

# ping 
apt install iputils-ping

# 安装 java
apt -y install openjdk-11-jdk
