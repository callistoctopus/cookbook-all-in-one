## 开启JMX服务

```
-Djava.rmi.server.hostname=**ip** 
-Dcom.sun.management.jmxremote.port=**port**
-Dcom.sun.management.jmxremote.ssl=false 
-Dcom.sun.management.jmxremote.authenticate=false  
```
***
## 指定内存大小
```
java -jar -Xms1024m -Xmx1536m -XX:PermSize=128M -XX:MaxPermSize=256M car.jar
```
1、**堆内存**：最小1024M(-Xms1024m)，最大1536M(-Xmx1536m)。（对象使用的内存）

2、**永久内存**：最小128M(-XX:PermSize=128M)，最大256M(-XX:MaxPermSize=256M)。（类使用的内存，PermGen）
***

## SPI

**API**（Application Programming Interface）在大多数情况下，都是实现方制定接口并完成对接口的实现，调用方仅仅依赖接口调用，且无权选择不同实现。 从使用人员上来说，API 直接被应用开发人员使用。  
**SPI** （Service Provider Interface）是调用方来制定接口规范，提供给外部来实现，调用方在调用时则选择自己需要的外部实现。  从使用人员上来说，SPI 被框架扩展人员使用。

https://www.cnblogs.com/jy107600/p/11464985.html

编译期注解处理器

***

## JNI机制

***

## 自定义ClassLoader
由于双亲委托机制，会由应用类加载器加载
如果加载的类，不在classpath里，意思就是应用类加载器加载不了，才会由此自定义加载器加载
*** 
