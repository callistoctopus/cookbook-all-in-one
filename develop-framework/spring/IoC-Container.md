## Introduction to the Spring IoC Container and Beans

The **org.springframework.beans** and **org.springframework.context** packages are the basis for Spring Framework’s IoC container. The ***BeanFactory*** interface provides an advanced configuration mechanism capable of managing any type of object. ***ApplicationContext*** is a sub-interface of BeanFactory.

In Spring, the objects that form the backbone of your application and that are managed by the Spring IoC container are called ***beans***. A bean is an object that is instantiated, assembled, and managed by a Spring IoC container

## Container Overview

Several implementations of the **ApplicationContext** interface are supplied with Spring. In stand-alone applications, it is common to create an instance of ***ClassPathXmlApplicationContext*** or ***FileSystemXmlApplicationContext***. 

### Configuration Metadata

Spring configuration consists of at least one and typically more than one bean definition that the container must manage. **XML-based** configuration metadata configures these beans as `<bean/>` elements inside a top-level `<beans/>` element. Java configuration typically uses `@Bean`-annotated methods within a `@Configuration` class.

*The following example shows the basic structure of XML-based configuration metadata:*
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="..." class="...">  
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <bean id="..." class="...">
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions go here -->

</beans>
```

### Instantiating a Container

```
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");
```

You can use the application context constructor to load bean definitions from all these XML fragments. This constructor takes multiple Resource locations, as was shown in the previous section. Alternatively, use one or more occurrences of the `<import/>` element to load bean definitions from another file or files. The following example shows how to do so:
```
<beans>
    <import resource="services.xml"/>
    <import resource="resources/messageSource.xml"/>
    <import resource="/resources/themeSource.xml"/>

    <bean id="bean1" class="..."/>
    <bean id="bean2" class="..."/>
</beans>
```
It is possible, but not recommended, to reference files in parent directories using a relative "../" path. 
### Using the Container

The **ApplicationContext** is the interface for an advanced factory capable of maintaining a registry of different beans and their dependencies. By using the method `T getBean(String name, Class<T> requiredType)`, you can retrieve instances of your beans.
```
// create and configure beans
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");

// retrieve configured instance
PetStoreService service = context.getBean("petStore", PetStoreService.class);

// use configured instance
List<String> userList = service.getUsernameList();
```

## Bean Overview
### Naming Beans
In XML-based configuration metadata, you use the **id** attribute, the **name** attribute, or both to specify the bean identifiers. The `id` attribute lets you specify exactly one id. Conventionally, these names are alphanumeric ('myBean', 'someService', etc.), but they can contain special characters as well. If you want to introduce other aliases for the bean, you can also specify them in the `name` attribute, separated by a comma (,), semicolon (;), or white space. 

Naming beans consistently makes your configuration easier to read and understand. 

With **component scanning** in the classpath, Spring generates bean names for unnamed components, following the rules described earlier: **essentially, taking the simple class name and turning its initial character to lower-case.**

### Aliasing a Bean outside the Bean Definition

Specifying all aliases where the bean is actually defined is not always adequate, however. It is sometimes desirable to introduce an alias for a bean that is defined elsewhere. 

In XML-based configuration metadata, you can use the `<alias/>` element to accomplish this. The following example shows how to do so:
```
<alias name="myApp-dataSource" alias="subsystemA-dataSource"/>
<alias name="myApp-dataSource" alias="subsystemB-dataSource"/>
```

### Instantiating Beans

