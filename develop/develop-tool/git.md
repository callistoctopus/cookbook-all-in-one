# git
安装教程  
https://www.runoob.com/git/git-install-setup.html

# 安装包
安装包下载地址：https://gitforwindows.org/
官网慢，可以用国内的镜像：https://npm.taobao.org/mirrors/git-for-windows/。

# 添加用户名及邮箱
git config --global user.name "callistoctopus"  
git config --global user.email 1101446261@qq.com

# 添加代理
git config --global http.proxy http://gui-qiH:Z7D8tijA@10.205.1.13:8080 
git config --global https.proxy http://gui-qiH:Z7D8tijA@10.205.1.13:8080

## 初期化命令
git init

## 添加远程仓库
git remote add origin `<git path>`

## 同步远程库
git pull origin master