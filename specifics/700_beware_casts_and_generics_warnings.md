## Beware Casts and Generics Warnings

### Summary

Casts dilute the benefit of Java's type system, making code both less readable and less safe.

Avoid casts whereever possible.

If you find yourself writing one, stop and ask yourself why you are writing it. 

What would need to be changed in your code so you did not need to write that cast? 

Why can't you make that change?

### Detail

Java's type system is there to help us - it catches bugs at compile-time and documents our code, making it easier to understand and navigate.

When we add a cast to our code, we lose both these benefits.

Casts get introduced into code for three main reasons:

1. We have reached the limits of Java's type system and the programmer must take control
2. The overall design of the code is poor
3. The code uses raw generic types

We'll look at these in reverse order.

#### Code with Raw Types

If code contains raw generic types (either because the code pre-dates Java 5 or the programmer is not familiar with Java) then it will create the need to cast.

For example:

```java
List list = numberList();
for (Object each : list) {
  Integer i = (Integer) each;
  // do things with integers
}
```

The compiler will not be happy that we have failed to fully declare the type of `List` we are dealing with and will (depending on how its been configured) generate an error or warning on the line where `list` is declared e.g.

```
List is a raw type. References to generic type List<E> should be parameterized
```

Similarly, for errant code such as:

```java
List l = new ArrayList<Number>();
List<String> ls = l;
```

The compiler will issue: 

```
Type safety: The expression of type List needs unchecked conversion to conform to List<String>`
```

Make sure that all such warnings should be addressed, either by imposing a zero compiler warnings policy or by configuring the compiler to treat them as errors.

In this case, removing both the cast and the warning is straight forward:

```java
List<Integer> list = numberList();
for (Integer each : list) {
   // do things with each
}
```

#### Poor Design

Sometimes, removing a cast or fixing a warning is non-trivial. We have bumped into issue two - poor design.

For example:

```java
List<Widget> widgets = getWidgets();
List results = process(widgets);
    
for (Object each : results) {
  if (each instanceof String) {
    // handle failure using data from string
  } else {
    EnhancedWidget widget = (EnhancedWidget) each;
    widget.doSomething();
  }
}
```

Normally, objects placed into a collection should be of a single type or of multiple types related by a common superclass or interface.   

Here, unrelated types have been placed into the same list with a String used to communicate some sort of information about how "processing" of a widget has failed.

The classic OO fix for this code would be to introduce a `ProcessResult` interface with two concrete implementations.

```java
interface ProcessResult {
 void doSomething(); 
}

class Success implements ProcessResult {
  
  private final EnhancedWidget result;
  
  @Override
  public void doSomething() {
    result.doSomething();
  }
  
}

class Failure implements ProcessResult {
  
  private final String result;
  
  @Override
  public void doSomething() {
    // do something with result string
  }
  
}
  
```

The original code can then be fixed as follows:

```java
List<Widget> widgets = getWidgets();
List<ProcessResult> results = process(widgets);
    
for (ProcessResult each : results) {
    each.doSomething();
  }
}
```

Or, more concisely in Java 8:

```java
 List<ProcessResult> results = process(widgets);
 results.stream().forEach(ProcessResult::doSomething); 
```

It may also sometimes make sense to use a disjoint union type aka `Either`.

This technique can be particularly useful as an interim step when reworking legacy code that uses mixed type raw collections, but can also be a sensible approach when dealing with error conditions.

Unfortunately, Java does not provide an `Either` type out of the box but at its simplest it looks something like:

```java
public class Either<L,R> {
  private final L left;
  private final R right;
  
  private Either(L left, R right) {
    this.left = left;
    this.right = right;
  }

  public static <L, R> Either<L, R> left(final L left) {
    return new Either<L, R>(left,null);
  }

  public static <L, R> Either<L, R> right(final R right) {
    return new Either<L, R>(null,right);
  }

  boolean isLeft() {
    return left != null;
  }

  L left() {
    return left;
  }

  R right() {
    return right;
  }
  
}
```

Libraries such as Atlassian's Fugue provide implementations with much richer functionality.

Using the simplistic form of `Either` with Java 7 the code could be re-written as:

```java
List<Widget> widgets = getWidgets();
List<Either<ProcessResult,String>> results = process(widgets);
    
for (Either<ProcessResult,String> each : results) {
  if (each.isLeft()) {
    // handle failure using data from string
  } else {  
    each.right().doSomething();
  }
}
```

While most Java programmers will prefer the earlier OO version, this version has two advantages:

1. It requires no change to the *structure* of the original code - all we have really done is make the types document what is happening
2. It requires less code

This pattern can help quickly tame a legacy code base that is difficult to comprehend.

#### Limits of the Type System

Sometimes we do reach the limits of Java's type system and need to cast. 

Before we do this, we must make certain that the cast is safe and there is no better solution to our problem. 

Similarly, we may need to sometimes suppress a Generics warning, this can be done by annotating with `@SuppressWarnings` e.g. 

```java
@SuppressWarnings("unchecked")
<T> T read(final Class<T> type, String xml) {
  return (T) fromXml(xml);
}

Object fromXml(final String xml) {
  return ... // de-serialise from string
}

```

Here, the compiler has no way of knowing what type has been serialized to the String. Hopefully the programmer does or else a runtime error will occur.

