# JDK 8 : Java SE 8u171/8u172

## windows
1. 下载JDK
http://www.Oracle.com/technetwork/Java/javase/downloads/index.html

2. 安装

3. 添加环境变量
   
JAVA_HOME <java安装路径>
PATH += %JAVA_HOME%/bin;%JAVA_HOME%/jre/bin

4. 验证
javac -version

# linux
1. 下载JDK
2. mkdir /usr/lib/jvm
3. tar -xzvf jdk-8u301-linux-x64.tar.gz -C /usr/lib/jvm
4. vim /etc/profile
5. #set oracle jdk environment
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_191 
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH 
5. source /etc/profile
6. java -version
 