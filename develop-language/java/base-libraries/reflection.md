# Reflection

Reflection is commonly used by programs which require the ability to examine or modify the **runtime behavior** of applications running in the Java virtual machine. 

For every type of object, the Java virtual machine instantiates an immutable instance of **java.lang.Class** which provides methods to examine the runtime properties of the object including its members and type information. `Class` also provides the ability to create new classes and objects. Most importantly, `it is the entry point for all of the Reflection APIs. `
***

# Classes

## Retrieving Class Objects 

`Object.getClass()`
```
Class c = "foo".getClass();
```

The `.class` Syntax
```
Class c = boolean.class; 
```

`Class.forName()`
```
Class c = Class.forName("com.duke.MyLocaleServiceProvider");
```

`TYPE` Field for Primitive Type Wrappers
```
Class c = Double.TYPE;
Class c = Void.TYPE;
```

Methods that Return Classes

`Class.getSuperclass()`  
Returns the super class for the given class.
```
Class c = javax.swing.JButton.class.getSuperclass();
```
`Class.getClasses()`  
Returns all the public classes, interfaces, and enums that are members of the class including inherited members.
```
Class<?>[] c = Character.class.getClasses();
```
`Class.getDeclaredClasses()`  
Returns all of the classes interfaces, and enums that are explicitly declared in this class.
```
Class<?>[] c = Character.class.getDeclaredClasses();
```
`Class.getDeclaringClass()`  
`java.lang.reflect.Field.getDeclaringClass()`  
`java.lang.reflect.Method.getDeclaringClass()`  
`java.lang.reflect.Constructor.getDeclaringClass()`    
Returns the Class in which these members were declared. Anonymous Class Declarations will not have a declaring class but will have an enclosing class.
```
import java.lang.reflect.Field;

Field f = System.class.getField("out");
Class c = f.getDeclaringClass();
```

`Class.getEnclosingClass()`  
Returns the immediately enclosing class of the class.  
```
Class c = Thread.State.class().getEnclosingClass();
```
The enclosing class of the enum Thread.State is Thread.  
```
public class MyClass {
    static Object o = new Object() { 
        public void m() {} 
    };
    static Class<c> = o.getClass().getEnclosingClass();
}
```
The anonymous class defined by o is enclosed by MyClass.

## Examining Class Modifiers and Types

A class may be declared with one or more modifiers which affect its runtime behavior:

* Access modifiers: public, protected, and private  
* Modifier requiring override: abstract
* Modifier restricting to one instance: static
* Modifier prohibiting value modification: final
* Modifier forcing strict floating point behavior: strictfp
* Annotations
  
`Class.getModifiers()`  
`Class.getTypeParameters()`  
`Class.getGenericInterfaces()`  
`Class.getSuperclass()`  
`Class.getAnnotations()`  
```java
import java.lang.annotation.Annotation;
import java.lang.reflect.Modifier;
import java.lang.reflect.Type;
import java.lang.reflect.TypeVariable;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import static java.lang.System.out;

public class ClassDeclarationSpy {
    public static void main(String... args) {
	try {
	    Class<?> c = Class.forName(args[0]);
	    out.format("Class:%n  %s%n%n", c.getCanonicalName());
	    out.format("Modifiers:%n  %s%n%n",
		       Modifier.toString(c.getModifiers()));

	    out.format("Type Parameters:%n");
	    TypeVariable[] tv = c.getTypeParameters();
	    if (tv.length != 0) {
		out.format("  ");
		for (TypeVariable t : tv)
		    out.format("%s ", t.getName());
		out.format("%n%n");
	    } else {
		out.format("  -- No Type Parameters --%n%n");
	    }

	    out.format("Implemented Interfaces:%n");
	    Type[] intfs = c.getGenericInterfaces();
	    if (intfs.length != 0) {
		for (Type intf : intfs)
		    out.format("  %s%n", intf.toString());
		out.format("%n");
	    } else {
		out.format("  -- No Implemented Interfaces --%n%n");
	    }

	    out.format("Inheritance Path:%n");
	    List<Class> l = new ArrayList<Class>();
	    printAncestor(c, l);
	    if (l.size() != 0) {
		for (Class<?> cl : l)
		    out.format("  %s%n", cl.getCanonicalName());
		out.format("%n");
	    } else {
		out.format("  -- No Super Classes --%n%n");
	    }

	    out.format("Annotations:%n");
	    Annotation[] ann = c.getAnnotations();
	    if (ann.length != 0) {
		for (Annotation a : ann)
		    out.format("  %s%n", a.toString());
		out.format("%n");
	    } else {
		out.format("  -- No Annotations --%n%n");
	    }

        // production code should handle this exception more gracefully
	} catch (ClassNotFoundException x) {
	    x.printStackTrace();
	}
    }

    private static void printAncestor(Class<?> c, List<Class> l) {
	Class<?> ancestor = c.getSuperclass();
 	if (ancestor != null) {
	    l.add(ancestor);
	    printAncestor(ancestor, l);
 	}
    }
}
```

## Discovering Class Members

**Class Methods for Locating Fields**  
| Class API | List of members? | Inherited members? | Private members? |
| :------- | :-------: | :-------: | :-------: | :-------: |
|getDeclaredField()|no|no|yes|
|getField()|no|yes|no|
|getDeclaredFields()|yes|no|yes|
|getFields()|yes|yes|no|

***

**Class Methods for Locating Methods**  
|Class API	|List of members?|	Inherited members?|	Private members?|
| :------- | :-------: | :-------: | :-------: | :-------: |
|getDeclaredMethod()	|no|	no|	yes|
|getMethod()	|no|	yes	|no|
|getDeclaredMethods()|	yes	|no	|yes|
|getMethods()	|yes|	yes|	no|

***

**Class Methods for Locating Constructors**
|Class API|	List of members?|	Inherited members?|	Private members?|
| :------- | :-------: | :-------: | :-------: | :-------: |
|getDeclaredConstructor()	|no	|N/A1|	yes|
|getConstructor()	|no|	N/A1|	no|
|getDeclaredConstructors()|	yes|	N/A1|	yes|
|getConstructors()|	yes	|N/A1|	no|
*** 

# Members
Reflection defines an interface `java.lang.reflect.Member` which is implemented by **java.lang.reflect.Field**, **java.lang.reflect.Method**, and **java.lang.reflect.Constructor**.

## Fields
A field is a class, interface, or enum with an associated value. Methods in the `java.lang.reflect.Field` class can retrieve information about the field, such as its **name**, **type**, **modifiers**, and **annotations**.  
There are also methods which enable dynamic access and modification of the value of the field. 

### Obtaining Field Types

```java
Field.getType()
```    
A field may be either of **primitive** or **reference type**. 

### Retrieving and Parsing Field Modifiers
There are several modifiers that may be part of a field declaration:

* Access modifiers: public, protected, and private
* Field-specific modifiers governing runtime behavior: transient and volatile
* Modifier restricting to one instance: static
* Modifier prohibiting value modification: final
* Annotations  
  
The method `Field.getModifiers()` can be used to return the integer representing the set of declared modifiers for the field. The bits representing the modifiers in this integer are defined in `java.lang.reflect.Modifier`.

 It also determines whether the located field is **synthetic (compiler-generated)** or is an enum constant by invoking `Field.isSynthetic()` and `Field.isEnumCostant()` respectively.

 ### Getting and Setting Field Values

 Given an instance of a class, it is possible to use reflection to set the values of fields in that class. 

 ## Methods

 The `java.lang.reflect.Method` class provides APIs to access information about a method's **modifiers**, **return type**, **parameters**, **annotations**, and **thrown exceptions**. It also be used to **invoke methods**.  

 ### Obtaining Method Type Information
 A method declaration includes the name, modifiers, parameters, return type, and list of throwable exceptions. The `java.lang.reflect.Method` class provides a way to obtain this information.

`Method.getName()`  
`Method.toGenericString()`  
`Method.getReturnType()`  
`Method.getGenericReturnType()`  
`Method.getParameterTypes()`  
`Method.getGenericParameterTypes()`  
`Method.getExceptionTypes()`  
`Method.getGenericExceptionTypes()`  