# 版本信息
lsb_release -a

# 设置apt代理
sudo gedit /etc/apt/apt.conf

Acquire::http::Proxy "http://gui-qiH:Z7D8tijA@10.205.1.13:8080";

# 配置curl,wget,pip代理
sudo vim ~/.bashrc

export http_proxy='http://gui-qiH:Z7D8tijA@10.205.1.13:8080'
export https_proxy='http://gui-qiH:Z7D8tijA@10.205.1.13:8080'
export ftp_proxy='http://gui-qiH:Z7D8tijA@10.205.1.13:8080'
export no_proxy='localhost'

source ~/.bashrc

# 查看已安装的软件
dpkg -l
dpkg -l | grep <softname>

# 查看软件版本
aptitude show <softname>

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

# 软件修复
apt --fix-broken install

# 安装deb文件 
dpkg -i <package.deb>

# 7z
apt-get install p7zip-full

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
 　  通过apt-get 安装，命令：apt-get install ssh -y

（3）启动SSH服务
　  命令：sudo /etc/init.d/ssh start

（4）修改SSH配置文件
 　命令：sudo vim /etc/ssh/sshd_config，找到PermitRootLogin without-password 修改为PermitRootLogin yes

（5）重启SSH服务
　命令：service ssh restart

# 安装systemctl 
apt-get -y install --reinstall systemd

# 安装网络工具
apt-get -y install net-tools

# 开机启动时自动运行程序
/etc/rc.d/rc.local 
该文件通常是系统最后启动的脚本

# Ubuntu 18.04 rc.local 设置开机自启动
1. 修改rc-local.service
/lib/systemd/system/rc-local.service新增：
[Install]
WantedBy=multi-user.target
Alias=rc-local.service

2. 设置开机自启动rc-local
systemctl enable rc-local

3. 创建/etc/rc.local
cat > /etc/rc.local << EOF
#!/bin/bash
echo "test rc.local " > /tmp/rctest.log
EOF

4. 新增执行权限
chmod +x /etc/rc.local

# 登录时自动运行程序
用户登录时，bash先自动执行系统管理员建立的全局登录script
/ect/profile

# 退出登录时自动运行程序
退出登录时，bash自动执行个人的退出登录脚本
/.bash_logout

# 定期自动运行程序
Linux有一个称为crond的守护程序，主要功能是周期性地检查 /var/spool/cron目录下的一组命令文件的内容，并在设定的时间执行这些文件中的命令。
用户可以通过crontab 命令来建立、修改、删除这些命令文件。

# 解决中文乱码
sudo apt-get install fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming

# ubuntu调整分辨率
xrandr
cvt 2560 1440
xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
xrandr --addmode VNC-0 "2560x1440_60.00"

# ubuntu 桌面版添加root密码
sudo passwd root