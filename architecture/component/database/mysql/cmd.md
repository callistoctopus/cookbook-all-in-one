## 安装客户端库文件
apt-get install libmysqlclient-dev

## 连接mysql服务器
mysql -u root -p

## 退出mysql服务器
exit

## 允许远程登陆
1. 登进MySQL

2. 输入以下语句，进入mysql库：  
    use mysql;

3. 更新域属性，'%'表示允许任意IP地址访问：  
    update user set host='%' where user ='root';

4. 再执行授权语句：  
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by '123456' WITH GRANT OPTION;
    grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;

5. 执行以上语句之后再执行：
    FLUSH PRIVILEGES;

6. vim /etc/mysql/mysql.conf.d/mysqld.cnf
   注释掉 bind-address          = 127.0.0.1

## Mysql 8
create user 'user'@'%' identified by '密码';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';

## 查看版本
select version();

## 显示表结构
desc ***;

## 设置参数

SHOW VARIABLES LIKE 'character_set_%';
SHOW GLOBAL VARIABLES LIKE 'character_set_%';

SET character_set_client = 'utf8';
SET character_set_connection = 'utf8';
SET character_set_database = 'utf8';
SET character_set_results = 'utf8';
SET character_set_server = 'utf8';
SET character_set_results = 'utf8';

SET GLOBAL  character_set_client = 'utf8';
SET GLOBAL  character_set_connection = 'utf8';
SET GLOBAL  character_set_database = 'utf8';
SET GLOBAL  character_set_results = 'utf8';
SET GLOBAL  character_set_server = 'utf8';
SET GLOBAL  character_set_results = 'utf8';