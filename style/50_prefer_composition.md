## Prefer Composition to Inheritance

### Summary

Composition usually results in more flexible designs. 

First consider using composition, then fall back to using inheritance only when composition does not seem to be a good fit.

### Details

Composition means building things by adding other things together. Inheritance is building things by extending behavior based on an existing class by creating a child classes.

To take a minimal example- If there is a requirement for a class to accept and store String values, some programmers new to Java will reach for inheritance as follows:

```java
class InheritanceAbuse extends ArrayList<String> {
  
  public void performBusinessLogic(int i) {
    // do things with stored strings
  }

}
```

The same functionality can be implemented using composition.

```java
class UsesComposition {
  
  private final List<String> values = new ArrayList<String>();
  
  public void performBusinessLogic(int i) {
    // do things with stored strings
  }
  
  public void add(String value) {
    this.values.add(value);
  }
  
}
```

Despite requiring more code, an experienced Java programmer would not even consider the first approach. So why is it that the second version is preferable? 

There are several overlapping explanations, we'll start with the most abstract and move on to more practical ones.

#### Inheritance is a Strong Relationship

Inheritance is used to model an IS-A relationship - i.e. we are saying that our `InheritanceAbuse` class is an ArrayList and we should be able to pass one to any piece of code that accepts an ArrayList.

Composition creates a HAS-A relationship; this is a weaker relationship and we should always favor weaker relationships in our code.

So favoring composition over inheritance is just one specific instance of the more general advice to favor weak relationships between our classes.

Using inheritance makes sense when there is an IS-A relationship there but it is an inappropriate mechanism to use purely for reusing code.

#### Inheritance Breaks Encapsulation

The inheritance implementation fails to encapsulate an implementation detail - that we're storing things in an ArrayList.

The interface to our class includes all sort of methods from ArrayList such as: 

* clear
* remove
* contains

Do these methods make sense for our class? If someone calls them, could it interfere with the logic in `performBusinessLogic`? 

We don't know enough about what our example class is meant to do to answer these questions definitively, but the answer is most likely that we would prefer not to expose these methods. 

If we switch from ArrayList to some other list implementation this is visible to the classes clients. Code that previously compiled may now break even if no methods specific to ArrayList are called - the change of type alone might cause compilation failures.

#### We Can Only Do This Once

Java doesn't support multiple inheritance so we only get to pick one thing to extend. If our class also needed to store Integers then inheritance isn't even an option so we'd have to use composition.

Composition is inherently more flexible in single inheritance languages. 

#### Composition Aids Testing

This is not relevant to our simple example, but it is trivial to test how classes linked together by composition interact. It is far harder when inheritance is used.

```java
class MyUntestableClass extends SomeDependency {
  public void performBusinessLogic(int i) {
    // do things using methods from SomeDependency 
  }
}
```

```java
class MyClass {
  private final SomeDependency dependency;

  MyClass(SomeDependency dependency) {
    this.dependency = dependency;
  }

  public void performBusinessLogic(int i) {
    // do things with dependency 
  }
}
```
It is easy to inject a mock into `MyClass`. Tricks exist to isolate the code in `MyUntestableClass` from `SomeDependency` for the purpose of unit testing, but they are far more involved.

#### Inheritance is Static

Inheritance sets a fixed relationship between concrete classes at compile time. With composition it is possible to swap in different concrete classes at runtime. 

Again composition is inherently more flexible.

### Interface Inheritance

The advice to prefer composition to inheritance refers to *implementation inheritance* (i.e. extending a class). The disadvantages discussed  above do not apply to *interface inheritance* (i.e. implementing an interface).

In fact, the design choice you often have to make is between implementation inheritance or a combination of composition and interface inheritance.

In these situations, the advice is still to prefer the approach that uses composition.

For example, the well known composition based Decorator pattern:

```java
class ProcessorUpperCaseDecorator implements Processor {

  private final Processor child;
  
  ProcessorUpperCaseDecorator(Processor child) {
    this.child = child;
  }

  @Override
  public void process(String someString) {
    child.process(someString.toUpperCase());
  }
  
}
```

Could also be implemented using inheritance

```java
class InheritanceUpperCaseDecorator extends ConcreteProcessor {
  
  @Override
  public void process(String someString) {
    super.process(someString.toUpperCase());
  }
  
}
```

But, again, this solution would be less flexible.

With the composition based version we can decorate any `Processor`. With the inheritance version we would need to re-implement the decorator for each concrete type to which we wished to add the upper case behaviour.

Many common OO patterns rely on the combination of Composition and interface inheritance.

### When to Use Implementation Inheritance

Almost anything that can be achieved with implementation inheritance can also be achieved using the combination of interface inheritance and composition.

So when should implementation inheritance be used?

Implementation inheritance has one single advantage over composition - it's less verbose.

So implementation inheritance should be used when **both** of the following conditions are met

1. There is an IS-A relationship to be modelled
2. The composition based approach would result in too much boilerplate code

The 2nd point is unfortunately entirely subjective.

