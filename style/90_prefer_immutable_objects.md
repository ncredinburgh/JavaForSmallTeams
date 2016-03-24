## Prefer Immutable Objects

### Summary

Where possible, create objects that cannot be changed - especially if those objects will be long-lived or globally accessible.

### Details

Mutable state makes programs harder to understand and maintain.

When objects are short-lived, and do not leave method scope, mutable state causes few problems. Writes and reads will be close together and there will be a clear order in which this happens.

For longer-lived objects, things are more complex.

If an object escapes from a method then it may be accessed from more than one location within the code.

We must start by assuming that anything that can happen to these objects will. We can only confirm that certain situations do not occur by examining the whole program.

The set of things that might happen to an immutable object is far smaller than for a mutable one. By constraining how long lived objects can behave we have made things simpler. There are fewer possibilities that we must consider.

Unfortunately, it is not always easy to tell from a class definition what the lifecycle of objects of that type will be. Perhaps only short-lived instances will be created. Perhaps only long-lived ones. Perhaps a mixture of the two.

If we design immutable classes by default we do not need to worry about this.

#### The Problem With Mutable Objects

If we have a very simple class such as `Foo`

```java
public class Foo {
  private Long id;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id);
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Foo other = (Foo) obj;
    return Objects.equals(id, other.id);
  }
}
```
We would need to search our codebase for all usages of it to establish the following :

##### It is Never Accessed from Multiple Threads

`Foo` is not thread safe.

Writes to longs are not atomic and nothing within `Foo` itself establishes a happens-before relationship between the field write and read.

If `setId` and `getId` are ever called from different threads we might get back stale or garbage values.

##### `setId` Is Never Called After `Foo` Has Been Placed in a Set

The `hashcode` of this class relies on a mutable field. If we modify it after we place it in a set then our program will not behave as we expect.

##### The Flow of Our Data

Even if our program behaves correctly, we need to do work in order to understand how it functions.

`setId` can be called at any point after the object is created. We can, therefore, only understand how data flows through our program by looking for all calls to `setId` - perhaps there are several, perhaps there is only one. The only way we can discover this is by examining the entire program.

#### Immutable Objects

If we can make our objects immutable we gain guarantees that mean we do not need to worry about how our objects are used.

```java
@Immutable
public final class Foo {
  private final Long id;

  public Foo(Long id) {
    this.id = id;
  }

  public Long getId() {
    return id;
  }

  @Override
  public int hashCode() {
    return Objects.hashCode(id);
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Foo other = (Foo) obj;
    return Objects.equals(id, other.id);
  }
}
```

It no longer matters if `Foo` is long or short lived.

It is inherently thread-safe. 

We know that whatever value we construct it with will remain until it dies. There is only one possible point where data is written so we do not need to search for others.

##### Annotations

The example uses the JSR3051 `javax.annotation.concurrent.Immutable` annotation. 

This does not in any way change the object's functionality but provides a way to communicate the intent of this being an immutable class. Static analysis tools such as [Mutablility Detector](https://github.com/MutabilityDetector/MutabilityDetector) can check if this intent has been violated.

We can tell at a glance that `Foo` is immutable as it has final fields of a well known immutable type. 

The `final` keyword ensures only that the reference a field points to will not change. 

If the field were of type `Bar` then we would not know if it were mutable or not without examining `Bar` to see if it too were immutable. Even if we were not using a static analysis tool the use of the `Immutable` annotation would make this assessment faster. 

Instead of updating the state of immutable objects, we create new instances that retain the state we do not wish to modify.

This pattern seems strange to some Java programmers at first, but the programming model is similar to how the familiar `String` class works.

```java
@Immutable
public final class Bar {
  private int anInt;
  private String aString;
  
  public Bar(int anInt, String aString) {
    this.anInt = anInt;
    this.aString = aString;
  }

  
  @CheckReturnValue
  public Bar withAnInt(int anInt) {
    return new Bar(anInt, this.aString);
  }

  @CheckReturnValue
  public Bar withAString(String aString) {
    return new Bar(this.antInt, aString);
  }
}
```

Instances of `Bar` with new values can be obtained by calling `withAString` and `withAnInt`. 

The JSR305 `javax.annotation.CheckReturnValue` enables static analysis tools such as [Error Prone](https://github.com/google/error-prone) to issue a warning if a mistake is made such as in the code below.

```java
public Bar doThings(Bar bar) {
  if(someLogic()) {
    bar.withAnInt(42);
  }
  return bar;
}
```

The call here to `withAnInt` achieves nothing because the return value is not stored. Most likely, the programmer intended to write:

```java
public Bar doThings(Bar bar) {
  if(someLogic()) {
    return bar.withAnInt(42);
  }
  return bar;
}
```

#### When to Use Mutable Objects

Mutable objects require slightly less boilerplate to create than immutable ones.

If you know that a class will only ever be used to create short-lived, local objects then you might consider making it mutable. But you must weigh this against the additional work required to ensure that the class is only ever used in this fashion as the codebase grows.

Options exist to auto-generate both immutable and mutable classes, thereby removing mutable objects' main advantage. Two of these options are discussed further in "Know How to Implement Hashcode and Equals".

Mutable objects used to be the norm in Java. As a result, many common frameworks require mutable objects. Persistence and serialization frameworks often require Java beans with no args constructors and setters. Other frameworks might require you to use two-stage construction with a lifecycle method such as init.

It is not always highlighted in the documentation but some long standing frameworks have been updated to support immutable objects. 

Jackson for example now allows constructors and factory methods to be annotated :-

```java
public class Foo  {
  private final int x
  private final int y;
  
  @JsonCreator
  public Foo(@JsonProperty("x") int x, @JsonProperty("y") int y) {
   this.x = x;
   this.y = y;
  }
}
```

Other frameworks, such as Hibernate, can only be used with classes that provide a default constructor. Although they can be configured to set fields directly without the need for setters this causes more problems than it solves. 

If you are tied to a framework that requires mutability then you will need to use mutable objects where you interface with that framework.

