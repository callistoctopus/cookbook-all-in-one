# 安装

1. 卸载原来的cmake版本:
sudo apt-get remove cmake

2. 从https://cmake.org/download/下载cmake源码

3. 解压
tar -zxvf cmake-3.17.1.tar.gz

4. 执行
./bootstrap 
(sudo apt-get install g++, sudo apt-get install libssl-dev)

5. 编译构建
make

6. 安装
sudo make install

7. 验证
cmake --version