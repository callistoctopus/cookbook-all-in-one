# linux安装mysql-c语言开发库

## 默认可能没有安装mysql的链接库, 使用下面语句安装

sudo apt-get install libmysqlclient-dev

## 使用下面两条命令查看库文件的位置和头文件的位置

mysql_config --libs
mysql_config --cflags

## 然后就可以使用

gcc in.c -o -lmysqlclient