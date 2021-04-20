
# 最小化安装，没有ifconfig默认没法联网
cd /etc/sysconfig/network-scripts/
sudo vi ifcfg-en33 也有可能是其他后缀
找到 ONBOOT=no 
修正为 ONBOOT=yes 

再执行 systemctl restart network 即可联网。

# 为 yum 设置网络代理

在/etc/yum.conf中添加：
proxy=http://192.168.2.56:8080
proxy_username=hanzhc
proxy_password=19920104Caishuang 

## 软件更新
**yum update**

## 安装软件
**yum install** *软件名称*
```
yum install libyaml-devel
```

# 查看IP
 ip addr