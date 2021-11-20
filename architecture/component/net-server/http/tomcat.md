1. 下载Tomcat 8.5

2. 解压
   tar -zxvf apache-tomcat-8.5.72.tar.gz -C /usr/local

3. 赋权限
   chmod 755 -R apache-tomcat-8.5.72

4. 修改启动脚本
   vi startup.sh

#set java environment
export JAVA_HOME=/usr/local/jdk1.8
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:%{JAVA_HOME}/lib:%{JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

#tomcat
export TOMCAT_HOME=/usr/local/apache-tomcat-8.5.72

5. 启动服务
   ./startup.sh