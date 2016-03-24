## Make Dependencies Explicit and Visible

### Summary

Make sure that the dependencies of a class are clearly visible.

Always inject dependencies into a class using it's constructor. Do not use other methods such as setters or annotations on fields.

Never introduce dependencies using hidden routes such as `Singletons` or `ThreadLocals`.

### Details

Code is easier to understand if the interfaces and classes that each object depends on are conspicuous and visible.

The most visible dependencies are the ones that are injected into a method as a parameter.

Less visible are the ones stored as fields but, depending on how those fields are populated, the dependencies can still be relatively easy to discover.

#### Constructor Injection

Constructor dependency injection clearly communicates an object's dependencies in a single location and ensures objects are only ever created in valid states. It allows fields to be made **final** so that their life cycle is unambiguous.

This is the only way in which dependencies should be injected.

#### Setter Injection

Setter injection increases the number of possible states an object could be in. Many of those states will be invalid.

If setter injection is used, a class can be constructed in a half-initialized state. What constitutes a fully-initialized state can only be determined by examining the code.

**Bad**
```java
public class Foo() {
  private Bar bar;

  public void doStuff() {
    bar.doBarThings();
  }

  public void setBar(Bar bar) {
    this.bar = bar;
  }
}
```

Here, a `NullPointerException` will be thrown if `Foo` is constructed without calling `setBar`.

**Better**
```java
public class Foo() {
  private final Bar bar;

  public Foo(Bar bar) {
    this.bar = bar;
  }

  public void doStuff() {
    bar.doBarThings();
  }
}
```

Here, it is clear that we must supply a `Bar` as we are unable to construct the class without it.

#### Field Annotations

While annotations on fields seem convenient they mean that the dependency will not be visible in the public API. They also tie construction of your class to the frameworks that understand them and prevent fields from being made final. 

Field annotations should not be used.

If you are working with a dependency injection framework such as Spring, either move construction of your objects into configuration classes or restrict the use on annotations to constructors. Both methods allow your classes to be constructed normally and ensure that all dependencies are visible.

#### Hidden Dependencies 

Anything that is not injected into a class using a constructor or as a method parameter is a hidden dependency.

These are evil.

They are pulled in from `Singletons`, `ThreadLocals`, static method calls or by simply calling `new`. 

**Bad**
```java
public class HiddenDependencies {
  public void doThings() {
    Connection connection = Database.getInstance().getConnection();
    // do things with connection
    ....
  }
}
```

Here we must ensure that the `Database` class is in a valid state before calling the `doThings` method of the code below, but we have no way of knowing this without looking through every line of code.

**Better**
```java
public class HiddenDependencies {
  private final Database database;

  public HiddenDependencies(Database database) {
    this.database = database;
  }

  public void doThings() {
    Connection connection = database.getConnection();
    // do things with connection
    ....
  }
}
```

Injecting via the constructor makes the dependency clearly visible.

By definition, hidden dependencies are hard to discover but they have a second issue - they are also hard to replace.

#### Seams

Seams are a concept introduced by Michael Feathers in "Working Effectively with legacy code"

He defines it as:

> "a place where you can alter behavior in your program without editing in that place."

In the original version of `HiddenDependencies`  if we wanted to replace `Database` with a mock or stub we could only do so if the singleton provided some method to modify the instance it returns. 

**Not a good approach**
````java
public class Database implements IDatabase {
  private static IDatabase instance = new Database();

  public static IDatabase getInstance() {
    return instance;
  }

  public static void setInstanceForTesting(IDatabase database) {
    instance = database;
  }

}
````

This approach introduces a seam but does not address our concerns around visibility. The dependency remains hidden.

If we used this approach, our codebase would remain hard to understand and we would find ourselves constantly fighting test order dependencies.

With constructor injection, we gain a seam and make the dependency visible. Even if `Database` is a singleton, we are still able to isolate our code from it for testing.

