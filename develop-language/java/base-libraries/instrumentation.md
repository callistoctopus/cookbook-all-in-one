## Instrumentation

Instrumentation是Java5提供的新特性。使用Instrumentation，开发者可以构建一个代理，用来监测运行在JVM上的程序。

通过Instrument，我们可以在JVM执行某个类文件之前，对该类文件的字节码进行适当的修改来达到我们的目的。

java.lang.instrument中需要关注的是ClassFileTransformer和Instrumentation接口。

***

### 基本步骤  

1. 定义一个代理类并添加premain(也就是在main执行前执行)方法。代理类可以是任何一个普通的Java类。
   ```
   public static void premain(String args, Instrumentation inst)
   ```
2. 定义一个实现ClassFileTransformer接口的转换类（通常由代理带实现即可）

3. 将第二步的转换类实例添加进Instrumentation里。
   ```
   inst.addTransformer(ClassFileTransformer);
   ```
***

### 示例

1. 添加代理类，并添加premain方法。同时我们让代理类实现ClassFileTransformer接口。
   ```
    package org.greenleaf;
 
    public class ApmAgent implements ClassFileTransformer {
        @Override
        public byte[] transform(ClassLoader loader, String className,
                        Class<?> classBeingRedefined, ProtectionDomain protectionDomain,
                        byte[] classfileBuffer) throws IllegalClassFormatException {
        }
    
        public static void premain(String agentArgs, Instrumentation inst) {
            inst.addTransformer(new ApmAgent());
        }
    }
    ```
2. 添加代码插入逻辑  
    我们需要借助字节码插入工具来完成我们的代码插入。最常用的字节码操作工具有javassist和ASM。由于javassist使用相对简单，在这里,我们使用javassist。关于javassist，读者可自行学习。
    ```
    ClassPool pool = new ClassPool(true);
    pool.appendClassPath(new LoaderClassPath(loader));
    try {
        CtClass cls = pool.makeClass(new ByteArrayInputStream(classfileBuffer));
        
        CtMethod[] methods = cls.getDeclaredMethods();
        for (CtMethod method : methods) {
            //插入本地变量
            method.addLocalVariable("startTime", CtClass.longType);
            String codeStrBefore = "startTime=System.currentTimeMillis();";
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("System.out.println(")
                    .append("\"" + method.getName() + " time cost \"").append(" +     (System.currentTimeMillis() - startTime) + \"毫秒\");");
        
            String codeStrAfter = stringBuilder.toString();
            System.out.println(codeStrBefore);
            System.out.println(codeStrAfter);
            method.insertBefore(codeStrBefore);
            method.insertAfter(codeStrAfter);
        }
    
        File file = new File("./target/", cls.getSimpleName() + ".class");
        try (FileOutputStream fileOutputStream = new FileOutputStream(file)) {
            fileOutputStream.write(cls.toBytecode());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cls.toBytecode();
    } catch (Exception e) {
        logger.error("", e);
    }
    return null;
    ```
3. 将ApmAgent编译并打包成jar.  
    需要在jar的META-INFO的MANIFEST.MF里添加如下信息。
    ```
    Premain-Class: org.greenleaf.ApmAgent
    Agent-Class: org.greenleaf.ApmAgent
    Can-Redefine-Classes: true
    Can-Retransform-Classes: true
    ```
    我们使用的是maven构建的jar. 读者也可以使用自己擅长的方式构建。使用maven在pom的配置信息如下：
    ```
    <build>
    <finalName>agent</finalName>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <configuration>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                    </manifest>
                    <manifestEntries>
                        <Premain-Class>org.greenleaf.ApmAgent</Premain-Class>
                        <Agent-Class>org.greenleaf.ApmAgent</Agent-Class>
                        <Can-Retransform-Classes>true</Can-Retransform-Classes>
                        <Can-Redefine-Classes>true</Can-Redefine-Classes>
                    </manifestEntries>
                </archive>
            </configuration>
        </plugin>
    </plugins>
    </build>
    ```
    执行
    ```
    mvn clean package
    ```
4. 使用代理
    1. 首先，新建一个测试类，
        ```
        public class App {
            public static void main(String[] args) {
                System.out.println("Hello World");
            }

            private int testMethod(int a ,int b) {
                return a + b;
            }
        }
        ```
    2. 然后，编译并运行生成的class。需要在java命令添加-javaagent:agent.jar参数. 我们使用exec-maven-plugin插件来运行java类。
        ```
        <build>
        <plugins>
            <plugin>
            <groupId>org.codehaus.mojo</groupId>
            <artifactId>exec-maven-plugin</artifactId>
            <version>1.2.1</version>
    
            <configuration>
                <executable>java</executable>
                <arguments>
                    <argument>-javaagent:${project.parent.basedir}/agentlib/target/agent.jar="传递的参数"</argument>
                    <argument>-classpath</argument>
                    <classpath/>
                    <mainClass>org.greenleaf.sample.App</mainClass> <!-- 程序入口，主类名称 -->
                </arguments>
            </configuration>
    
            </plugin>
        </plugins>
        </build>
        ```

参考：  
https://www.cnblogs.com/wade-luffy/p/6078301.html