# 交叉编译工具Linaro

## 安装包下载
>>需要根据系统选择合适的安装包，不合适的安装包可能导致错误（version GLIBC_2.27 not found）
<最新版>
https://snapshots.linaro.org/gnu-toolchain/
<历史版本>
https://releases.linaro.org/components/toolchain/binaries/

## 安装

解压
tar -Jxf <packagename>

更改权限
sudo chmod -R 777 <packagedir>

# mysql-connector-c源码下载

<mysql-connector-c>
https://downloads.mysql.com/archives/c-c/

# 主机编译

tar -zxf mysql-connector-c-6.1.11-src.tar.gz
mv mysql-connector-c-6.1.11-src mysql-connector-c-6.1.11-src-x86
cd mysql-connector-c-6.1.11-src-x86
mkdir build && cd build
cmake ..
make

# 交叉编译

## 修改CMakeLists.txt

>>在文件内容开始处添加一下内容

#####################################################
SET(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_SYSTEM_PROCESSOR arm)
SET(CMAKE_SYSTEM_VERSION 1)

set(CMAKE_SYSROOT /home/narada/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/libc)

# specify the cross compiler
set(tools /home/narada/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf)
set(CMAKE_C_COMPILER ${tools}/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/arm-linux-gnueabihf-g++)
SET(CMAKE_C_LINKER_EXECUTABLE ${tools}/bin/arm-linux-gnueabihf-ld)

set(CMAKE_FIND_ROOT_PATH /home/narada/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/libc)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)

# search for programs in the build host directories
# for libraries and headers in the target directories
SET(STACK_DIRECTION 1)
SET(HAVE_LLVM_LIBCPP OFF)
SET(HAVE_C_FLOATING_POINT_OPTIMIZATION_PROBLEMS OFF)
SET(HAVE_CXX_FLOATING_POINT_OPTIMIZATION_PROBLEMS OFF)
#####################################################


## 环境准备
把刚才主机平台的【build/extra】目录下的所有可执行文件都拷贝到目标平台的【build/extra】文件夹下，
有【comp_err，my_print_defaults，perror，resolveip】。
拷贝过来之后需要把目标平台的【build/extra】加到环境变量。

## 执行命令
tar -zxf mysql-connector-c-6.1.11-src.tar.gz
mv mysql-connector-c-6.1.11-src mysql-connector-c-6.1.11-src-arm
cd mysql-connector-c-6.1.11-src-arm
mkdir build && cd build
export PATH=$PATH:`pwd`/extra
make

## 结束
在【build/libmysql】下有编译好的静态和动态库。
