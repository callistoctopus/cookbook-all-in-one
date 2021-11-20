
# 最小化安装，没有ifconfig默认没法联网
cd /etc/sysconfig/network-scripts/
sudo vi ifcfg-en33 也有可能是其他后缀
找到 ONBOOT=no 
修正为 ONBOOT=yes 

再执行 systemctl restart network 即可联网。

# 修改IP地址
cd /etc/sysconfig/network-scripts/
sudo vi ifcfg-en33 也有可能是其他后缀
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.110.220
GATEWAY=192.168.110.1
NETMASK=255.255.255.0
DNS1=192.168.110.1

再执行 systemctl restart network 即可。

# 为 yum 设置网络代理

在/etc/yum.conf中添加：
proxy=http://10.205.1.13:8080
proxy_username=gui-qiH
proxy_password=Z7D8tijA

# 设置代理
HTTP_PROXY=http://gui-qiH:Z7D8tijA@10.205.1.13:8080
HTTPS_PROXY=http://gui-qiH:Z7D8tijA@10.205.1.13:8080
export HTTP_PROXY HTTPS_PROXY

# 设置yum镜像

1. 备份
   mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

2. 下载新的 CentOS-Base.repo 到 /etc/yum.repos.d/
   CentOS 6
   wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-6.repo
   或者
   curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-6.repo

   CentOS 7
   wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
   或者
   curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo

   CentOS 8
   wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo
   或者
   curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo

3. sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo

4. 运行 yum makecache 生成缓存

## 软件更新
yum update -y

## 安装软件
yum install -y <app>
yum install libyaml-devel

rpm -i <soft>.rpm

## 查看库的依赖包
yum provides */<libname>

# 查看IP
 ip addr

# 设置防火墙
systemctl status firewalld.service
systemctl disable firewalld.service
systemctl stop firewalld.service

# 启动服务
systemctl start ***
# 关闭服务
systemctl stop ***
# 开机自启动服务
systemctl enable ***
# 是否开机自启动
systemctl is-enabled ***

# 安装远程服务
yum install -y openssl openssh-server
systemctl start sshd.service
systemctl enable sshd.service

# 安装图形化界面
yum groupinstall "Server with GUI" -y --allowerasing

# 安装远程桌面服务
1. 默认库不包含xrdp，需要安装epel库。
yum -y install epel-release
2. 然后安装xrdp
yum -y install xrdp
3. 启动xrdp并设置开机启动
systemctl start xrdp
systemctl enable xrdp
4. 安装好了之后将防火墙关闭,或者开放3389端口
systemctl stop firewalld
systemctl disable firewalld

# 允许远程登陆
vi /etc/ssh/sshd_config
#PermitRootLogin yes -> PermitRootLogin yes
systemctl restart sshd

# 添加用户
adduser linuxidc
passwd linuxidc

# 切换用户名
su - 用户名

# 安装httpd
yum install httpd

# CentOS7使用iptables进行网络管理
1. 禁用和注销firewalld防火墙服务
   systemctl stop firewalld
   systemctl mask firewalld

2. 安装iptables-services包
   yum install iptables-services
   
3. 服务器启动时自动开启服务
   systemctl enable iptables

4. 按照需要操作防火墙
   systemctl [stop|start|restart] iptables
   或者
   service [stop|start|restart] iptables

5. service iptables save


# 禁用SELinux
setenforce 0
vi /etc/selinux/config
SELINUX=permissive

# 修改主机名
hostnamectl set-hostname 

# 编译工具 
gcc: yum -y install gcc
g++: yum -y install gcc-c++
cmake: install -y cmake

# 7z
yum -y install epel-release
yum -y install p7zip p7zip-plugins