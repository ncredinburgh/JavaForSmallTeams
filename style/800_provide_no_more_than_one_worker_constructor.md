## Provide no More Than One Worker Constructor

### Summary

Although a class may provide many constructors, only one should write to fields and initialise the class.

### Details

Having a single place where fields are assigned during construction makes it easy to understand the states that class can be constructed in. 

Classes should not provide multiple constructors that set fields.

**Bad**
```java
public class Foo {
  private final String a;
  private final Integer b;
  private final Float c;

  public Foo(String value) {
    this.a = Objects.requireNonNull(value);
    this.b = 42;
    this.c = 1.0f;
  }

  public Foo(Integer value) {
    this.a = "";
    this.b = Objects.requireNonNull(value);
    this.c = 1.0f;
  }

  public Foo(Float value) {
    this.a = "";
    this.b = 42;
    this.c = Objects.requireNonNull(value);
  }
}
```
The duplication of values in the above code could be removed but it would remain confusing because the concern of initializing the class is spread across three locations. 

If more fields were to be added, it would be easy to forget to initialize them in the existing constructors. 

Fortunately, we have made all fields final so this would give a compilation error. If the class was mutable, we would have a bug to discover at runtime.

**Better**
```java
public class Foo {
  private final String a;
  private final Integer b;
  private final Float c;

  private Foo(String a, Integer b, Float c) {
    this.a = Objects.requireNonNull(a);
    this.b = Objects.requireNonNull(b);
    this.c = Objects.requireNonNull(c);
  }

  public Foo(String value) {
    this(value, 42, 1.0f);
  }

  public Foo(Integer value) {
    this("", value, 1.0f);
  }

  public Foo(Float value) {
    this("", 42, value);
  }
}
```

Fields are now only written in one location, resulting in less duplication.

We can also see at a glance that `Foo` cannot be constructed with null values. In the previous version, this could only be determined by scanning three different locations.

Following this pattern, it is difficult to forget to set a field even if it is non-final.


