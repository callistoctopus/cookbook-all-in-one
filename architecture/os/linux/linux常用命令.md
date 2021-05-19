
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

***

## 下载文件
**curl** *url* **--output** *filename*  
```shell
curl https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz --output ruby-1.9.3-p392.tar.gz
```
***

## 解压命令
**tar** **-xzvf** *压缩文件名* 
``` 
tar -xzvf ruby-1.9.3-p392.tar.gz
```
***

## 运行命令
**./**<命令>  
```
./configure
```
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
su
vi /etc/sudoers
找到“root    ALL=(ALL)       ALL”一行，在下面插入新的一行
:wq! 保存并退出。