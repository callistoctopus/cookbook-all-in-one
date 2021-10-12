# Linux查看某个库的位置/是否安装
ldconfig -p | grep libnccl

ldconfig -p: 打印当前缓存所保存的所有库的名字。
grep libnccl: 用管道符解析libpcap.so是否已加入缓存中。

# linux 添加动态链接库路径
1)
export  LD_LIBRARY_PATH=你的库的路径:$LD_LIBRARY_PATH
echo  $LD_LIBRARY_PATH

linux 默认回去/lib和/usr/lib目录下查找库

2)
在 /etc/ld.so.conf 文件中添加库的搜索路径
运行 /sbin/ldconfig 命令更新 /etc/ld.so.cache

# 添加C头文件路径
C_INCLUDE_PATH=<path>
export C_INCLUDE_PATH

# 添加C++头文件路径
CPLUS_INCLUDE_PATH=<path>
export CPLUS_INCLUDE_PATH

# 安装Openssl
sudo apt-get install libssl-dev

# OpenSSL Linux动态库编译

src:
https://www.openssl.org/source/

静态库编译

./config 
make
make install

动态库编译

./config shared
make
make install

