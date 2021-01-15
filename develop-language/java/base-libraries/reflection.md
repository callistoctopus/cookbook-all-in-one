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

### Obtaining Names of Method Parameters

You can obtain the names of the formal parameters of any method or constructor with the method `java.lang.reflect.Executable.getParameters`.  
**However, .class files do not store formal parameter names by default**. This is because many tools that produce and consume class files may not expect the larger static and dynamic footprint of .class files that contain parameter names. In particular, these tools would have to handle larger .class files, and the Java Virtual Machine (JVM) would use more memory.

To store formal parameter names in a particular .class file, and thus enable the Reflection API to retrieve formal parameter names, compile the source file with the `-parameters` option to the javac compiler.

### Retrieving and Parsing Method Modifiers

There a several modifiers that may be part of a method declaration:

* Access modifiers: public, protected, and private
* Modifier restricting to one instance: static
* Modifier prohibiting value modification: final
* Modifier requiring override: abstract
* Modifier preventing reentrancy: synchronized
* Modifier indicating implementation in another programming language:native
* Modifier forcing strict floating point behavior: strictfp
* Annotations

`Method.getModifiers()`  
lists the modifiers of a method with a given name. 

`Method.isSynthetic()`  
whether the method is synthetic (compiler-generated)

`Method.isVarArgs()`  
of variable arity

`Method.isBridge()`  
or a bridge method (compiler-generated to support generic interfaces)

### Invoking Methods

Reflection provides a means for invoking methods on a class. Typically, this would only be necessary if it is not possible to cast an instance of the class to the desired type in non-reflective code. Methods are invoked with `java.lang.reflect.Method.invoke()`. The **first argument** is the **object instance** on which this particular method is to be invoked. (*If the method is static, the first argument should be null.*) Subsequent arguments are the method's parameters. If the underlying method throws an exception, it will be wrapped by an `java.lang.reflect.InvocationTargetException`. The method's original exception may be retrieved using the exception chaining mechanism's `InvocationTargetException.getCause()` method.
```
Object o = m.invoke(t, new Locale(args[1], args[2], args[3]));
```
```
main.invoke(null, (Object)mainArgs);
```

## Constructors

A `constructor` is used in the creation of an object that is an instance of a class. Typically it performs operations required to initialize the class before methods are invoked or fields are accessed. Constructors are never inherited.

A constructor declaration includes the name, modifiers, parameters, and list of throwable exceptions. The `java.lang.reflect.Constructor `class provides a way to obtain this information.

```
Constructor[] allConstructors = c.getDeclaredConstructors();
```

Note that the first listed constructor is package-private, not public. It is returned because the example code uses `Class.getDeclaredConstructors()` rather than `Class.getConstructors()`, which returns only public constructors.

### Retrieving and Parsing Constructor Modifiers
Because of the role of constructors in the language, fewer modifiers are meaningful than for methods:

* Access modifiers: public, protected, and private
* Annotations

```
ctor.getModifiers()
```

### Creating New Class Instances

There are two reflective methods for creating instances of classes: java.lang.reflect.Constructor.newInstance() and Class.newInstance(). The former is preferred and is thus used in these examples because:

* Class.newInstance() can only invoke the zero-argument constructor, while Constructor.newInstance() may invoke any constructor, regardless of the number of parameters.
* Class.newInstance() throws any exception thrown by the constructor, regardless of whether it is checked or unchecked. Constructor.newInstance() always wraps the thrown exception with an InvocationTargetException.
* Class.newInstance() requires that the constructor be visible; Constructor.newInstance() may invoke private constructors under certain circumstances.

```
Constructor ctor = EmailAliases.class.getDeclaredConstructor(HashMap.class);
```
# Arrays and Enumerated Types

From the Java virtual machine's perspective, arrays and enumerated types (or enums) are just classes. Many of the methods in Class may be used on them. Reflection provides a few specific APIs for arrays and enums. 

## Arrays

Arrays have a component type and a length (which is not part of the type). Arrays may be maniuplated either in their entirety or component by component. Reflection provides the java.lang.reflect.Array class for the latter purpose.

### Identifying Array Types
Array types may be identified by invoking `Class.isArray()`. 

```java
boolean found = false;
 	try {
	    Class<?> cls = Class.forName(args[0]);
	    Field[] flds = cls.getDeclaredFields();
	    for (Field f : flds) {
 		Class<?> c = f.getType();
		if (c.isArray()) {
		    found = true;
		    out.format("%s%n"
                               + "           Field: %s%n"
			       + "            Type: %s%n"
			       + "  Component Type: %s%n",
			       f, f.getName(), c, c.getComponentType());
		}
	    }
	    if (!found) {
		out.format("No array fields%n");
	    }

        // production code should handle this exception more gracefully
 	} catch (ClassNotFoundException x) {
	    x.printStackTrace();
	}
```

### Creating New Arrays

Just as in non-reflective code, reflection supports the ability to dynamically create arrays of arbitrary type and dimensions via `java.lang.reflect.Array.newInstance()`.
```java
... ...
int n = cVals.length;
Class<?> c = Class.forName(cName);
Object o = Array.newInstance(c, n);
for (int i = 0; i < n; i++) {
	String v = cVals[i];
	Constructor ctor = c.getConstructor(String.class);
	Object val = ctor.newInstance(v);
	Array.set(o, i, val);
}
``` 

### Getting and Setting Arrays and Their Components

Just as in non-reflective code, an array field may be set or retrieved in its entirety or component by component. **To set the entire array at once**, use `java.lang.reflect.Field.set(Object obj, Object value)`. **To retrieve the entire array**, use `Field.get(Object)`. Individual components can be set or retrieved using methods in `java.lang.reflect.Array`.  

Array provides methods of the form setFoo() and getFoo() for setting and getting components of any primitive type. For example, the component of an int array may be set with `Array.setInt(Object array, int index, int value)` and may be retrieved with `Array.getInt(Object array, int index)`.

method `java.util.Arrays.copyOf). java.util.Arrays` contains many methods which are convenient when operating on arrays.

The variable argument `Array.newInstance(Class<?> componentType, int... dimensions)` provides a convenient way to create multi-dimensional arrays, but the components still need to initialized using the principle that that multi-dimensional arrays are nested arrays.

## Enumerated Types

An enum is a language construct that is used to define type-safe enumerations which can be used when a fixed set of named values is desired. All enums implicitly extend `java.lang.Enum`. Enums may contain one or more enum constants, which define unique instances of the enum type. An enum declaration defines an enum type which is very similar to a class in that it may have members such as fields, methods, and constructors (with some restrictions).

The only **Reflection APIs that are specific to enums** are `Class.isEnum()`, `Class.getEnumConstants()`, and `java.lang.reflect.Field.isEnumConstant()`.

### Examining Enums

Reflection provides three enum-specific APIs:

* `Class.isEnum()`  
Indicates whether this class represents an enum type  
* `Class.getEnumConstants()`  
Retrieves the list of enum constants defined by the enum in the order they're declared
* `java.lang.reflect.Field.isEnumConstant()`  
Indicates whether this field represents an element of an enumerated type

Sometimes it is necessary to dynamically retrieve the list of enum constants; in **non-reflective code** this is accomplished by invoking the implicitly declared static method `values()` on the enum. If an instance of **an enum type is not available** the only way to get a list of the possible values is to invoke `Class.getEnumConstants()` since it is impossible to instantiate an enum type.

### Getting and Setting Fields with Enum Types

Fields which store enums are set and retrieved as any other reference type, using `Field.set()` and `Field.get()`.