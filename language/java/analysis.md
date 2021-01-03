
## Oracle 官网
https://docs.oracle.com/ 

* ### java se 8 doc
    https://docs.oracle.com/javase/8/docs/index.html  
    https://docs.oracle.com/javase/8/docs/api/

* ### java ee 7 doc
    https://docs.oracle.com/javaee/7/tutorial/index.html  
    https://docs.oracle.com/javaee/7/api/toc.htm

***

## spring 官网
https://spring.io/

***

## VisualVM官网

https://visualvm.github.io/

***

## 开启JMX服务

```
-Djava.rmi.server.hostname=**ip** 
-Dcom.sun.management.jmxremote.port=**port**
-Dcom.sun.management.jmxremote.ssl=false 
-Dcom.sun.management.jmxremote.authenticate=false  
```

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