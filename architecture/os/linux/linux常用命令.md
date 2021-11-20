# 查看到当前linux系统的发行版本信息
cat /etc/issue

# 查看到linux当前运行的内核版本
cat /proc/version
或
uname -srm
或
hostnamectl

# 显示 Linux 系统架构
uname -a

# 显示系统32位还是64位
getconf LONG_BIT

## linux系统间文件拷贝命令(scp)
**scp** *src* *user*@*host*:*dst*

***

## 编辑文件(vi)
  **vi** *文件名*  
```shell
vi Gemfile
```
###  进入编辑模式
**i**

###  进入命令模式
**[Esc]**  
**:**

### 保存文件命令
**wq**

### 查找文件
命令模式下输入“/字符串”，例如“/Section 3”
输入你需要查找的关键字，回车
如果要继续查找关键字，输入n
向前查找，输入N（大写）


## 查找文件
find <path> -name <filename>

## 查看文件属性
file <filename>

## 查看命令位置
which <cmd>
>>which gcc

### 向文件末尾追加
echo 'add content'>>/home/data/test.sh
>> 是追加
echo 'add content'>/home/data/test.sh
> 是删除原有内容，添加

***

## 下载文件
**curl** *url* **--output** *filename*  
```shell
curl https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz --output ruby-1.9.3-p392.tar.gz
```
***

# 压缩命令
tar -czvf <name>.tar.gz <needcomprose>

## 解压命令
**tar** **-xzvf** *压缩文件名* 
tar -xzvf ruby-1.9.3-p392.tar.gz -C <dstpath>

## 解压xz文件
tar -Jxf <file.xz>
***

## zip压缩命令
zip -r <name>.zip <dir>

## 7z解压缩
7za a -t7z -m0=lzma2 -mx=9 -mmt=4 <name>.7z <needcomprose>
7z x <name>.7z

## 运行命令
**./**<命令>  
./configure
***

## 查看所有环境变量
env

## 添加环境变量
```
vi /etc/environment
PATH="[old]:$JAVA_HOME/bin"
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib  
export JAVA_HOME=/usr/local/jdk1.8.0_181
```

export PATH=$PATH:directory
***

## 脚本文件
```
#! /usr/bin/env bash  
echo "------online scan start------"  
echo `date`  
source /etc/profile  
rvm use 1.9.3-p392  
ruby -v  
ruby /data/op/vmoss/bat/script/online_scan.rb  
echo "------online scan end------"  
```

***

## 变更文件访问权限
**chmod** *权限码* *文件名*
```
chmod 777 online_columninfo.sh
```
### 更改dir中全部内容的权限
chmod -R 777 <dir>
***

## 添加定时任务
```
crontab -e
```
```
* * * * * /data/online_scan.sh >> /data/log_online_scan.log
* * * * * /data/online_columninfo.sh >> /data/log_online_columninfo.log
* * * * * /data/task_scan.sh >> /data/log_task_scan.log
```

## linux远程linux
**ssh** *username* **@** *host*
```
ssh root@localhost
```

## 追加用户权限
chmod 777 /etc/sudoers
vi /etc/sudoers
找到“root    ALL=(ALL)       ALL”一行，在下面插入新的一行
user    ALL=(ALL)       ALL
:wq! 保存并退出。
chmod 555 /etc/sudoers

## 设置命令别名
alias k=kubectl


## 使用iptables进行端口转发

1. 配置/etc/sysctl.conf文件的 net.ipv4.ip_forward = 1 默认是0, 允许iptalbes FORWARD。
2. service iptables stop  关闭防火墙
3. 本地接口IP 61.144.a.b 的3389端口 转发到 116.6.c.d的3389
   iptables -t nat -A PREROUTING --dst 61.144.a.b -p tcp --dport 3389 -j DNAT --to-destination 116.6.c.d:3389
   iptables -t nat -A POSTROUTING --dst 116.6.c.d -p tcp --dport 3389 -j SNAT --to-source 61.144.a.b
4. service iptables save
5. service iptables start


# 查看端口
netstat -aptn
apt-get -y install net-tools

# 查看远程端口
telnet ip port
yum install -y telnet


# 查看当前时间
date

# 修改时间
date -s hh:mm:ss
date -s "yyyy-MM-dd hh:mm:ss"

## 将时间写入bios避免重启失效
hwclock -w


# 执行脚本
bash <(curl -L <remote.sh>)

# 修改屏幕分辨率
xrandr
cvt 2560 1440
xrandr --newmode "2560x1440_60.00" 312.25 2560 2752 3024 3488 1440 1443 1448 1493 -hsync +vsync
xrandr --addmode <OUTPUT> "2560x1440_60.00"
xrandr --output <OUTPUT> --mode "2560x1440_60.00"

# 跟踪网络路由
traceroute www.baidu.com