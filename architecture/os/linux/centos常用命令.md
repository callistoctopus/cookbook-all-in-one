
## 软件更新
**yum update**

## 安装软件
**yum install** *软件名称*
```
yum install libyaml-devel
```

# 最小化安装，没有ifconfig默认没法联网
cd /etc/sysconfig/network-scripts/
sudo vi ifcfg-en33 也有可能是其他后缀
找到 ONBOOT=no 
修正为 ONBOOT=yes 

再执行 systemctl restart network 即可联网。