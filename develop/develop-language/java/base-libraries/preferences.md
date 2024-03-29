# Preferences

`Preferences`提供一个存储配置信息的中心知识库，与平台无关。在Windows系统中，它存储在注册表中，在Linux中存储在本地文件系统中。它的实现是透明的，程序员无需深究它的底层是如何实现的。

Preferences的中心知识库是**树状结构**，因此可以避免文件名冲突。每个用户都有一棵树，存放与本用户有关的配置；还有一个系统树，存放全体用户的公共信息。内部的配置信息仍然以**key-value**的结构进行存储。

Preferences的使用步骤如下：

（1）获得根节点

```java
Preferences root = Preferences.userRoot();
Preferences root = Preferences.systemRoot();
```

如果配置信息位于用户树，则获取用户树的根节点，否则获取系统树根节点；

（2）获取配置节点
```
preferences = root.node("path");
```

path是配置节点相对于根节点的路径；

如果节点的路径名与类的包名相同，则可通过类的对象直接获得配置节点：
```
Preferences node = Preferences.userNodeForPackage(this.getClass());
Preferences node = Preferences.systemNodeForPackage(this.getClass());
```

（3）读取配置项
```
String title =  preferences.get("title", "default title");
```
Preferences要求读取配置项时必须指定默认值。因为在实际环境中总会有各种不如意，比如系统中还没有中心知识库，或者网络暂时不可用等等。

（4）设置配置项
```
preferences.put(key, value);
```
（5）同步配置项
```
preferences.flush();
```
flush()方法用于立即将配置项写入到文件中。