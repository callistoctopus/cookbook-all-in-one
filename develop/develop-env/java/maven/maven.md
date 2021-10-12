# 通用

1. 官网下载地址
https://maven.apache.org/download.cgi

# windows
1. 解压到指定目录
2. 添加环境变量
MAVEN_HOME <maven解压目录>
PATH += %MAVEN_HOME%/bin

# linux
2. mkdir /usr/lib/maven
3. tar -xzvf apache-maven-3.8.3-bin.tar.gz -C /usr/lib/maven
4. vi /etc/profile
5. #set maven environment
export MAVEN_HOME=/usr/lib/maven/apache-maven-3.8.3 
export PATH=${MAVEN_HOME}/bin:$PATH 
6. source /etc/profile

# 通用

7. MAVEN配置
配置文件路径 <maven解压目录>/conf/settings.xml

配置本地仓库
<localRepository>D:\apache-maven-3.6.1\localRepository</localRepository>

配置代理
<proxy>
    <id>fe-proxy</id>
    <active>true</active>
    <protocol>http</protocol>
    <username>gui-qiH</username>
    <password>Z7D8tijA</password>
    <host>10.205.1.13</host>
    <port>8080</port>
</proxy>

配置中央仓库
<mirror>
    <id>alimaven</id>
    <mirrorOf>central</mirrorOf>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>
</mirror>

5. 验证是否安装成功
mvn -v