
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
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION;
    grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;

5. 执行以上语句之后再执行：
    FLUSH PRIVILEGES;

6. vim /etc/mysql/mysql.conf.d/mysqld.cnf
   注释掉 bind-address          = 127.0.0.1

## 查看版本
select version();

## 显示表结构
desc ***;