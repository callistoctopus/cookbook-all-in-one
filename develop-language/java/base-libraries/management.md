# Monitoring and Management
for the Java Platform
The Java Platform Standard Edition provides comprehensive monitoring and management support for the Java platform. 

# API Specifications
Java SE includes the following APIs for monitoring and management:

* **java.lang.management** - Enables monitoring and managing the Java virtual machine and the underlying operating system.  The API enables applications to monitor themselves and enables JMX-compliant tools to monitor and manage a virtual machine locally and remotely.
* **com.sun.management** - Oracle's platform extension to the java.lang.management API and the management interface for some other components of the platform.
* **java.util.logging.LoggingMXBean** - Enables you to retrieve and set logging information.
* **The Java Management Extensions (JMX) APIs** - Defines the architecture, design patterns, interfaces, and services for application and network management and monitoring in Java. For more information, see the JMX documentation.
* **The Attach API** - Oracle's platform extension that allows a management agent to be dynamically loaded into a virtual machine.
* **The JConsole API** - platform extension that provides a programmatic interface to access JConsole such as adding a JConsole plugin. JTop is an example JConsole plugin available at the JDK_HOME/demo/management/JTop directory.