## Avoid Null Whenever Possible

### Summary

Null is a billion dollar mistake, make sure you know how to avoid using it in your code.

Try to limit the times you or your clients need to write the following:

```java
  if ( != null ) {
    ...
  }
```
### Details

Although it is likely that libraries and frameworks you interact with will return null, you should try to ensure that this practice is isolated to third party code. 

The core of your application should assume that it does not have to worry about null values. 

Strategies to avoid null include :

* The null object pattern - when you have something you think is optional
* The type-safe null pattern (aka Option, Optional & Maybe) - when you need to express that an interface might not return something
* Design by contract

### The Null Object Pattern

The null object pattern is the classic OO approach to avoiding null. You should use it whenever you think you have a dependency that you think is optional.

The pattern is very simple, just provide an implementation of the interface that that does "nothing" or has a neutral behavior. This can then be safely referenced by it's clients, with no need to check for null.

### Type-Safe Nulls (Optional)

The type-safe null pattern is familiar in most functional programming languages where is variously known as Maybe, Option or Optional. Java 8 finally adds an Optional type, but implementations are available for earlier versions via Guava and other libraries.

It is a simple pattern. An Optional is basically just a box that can hold either one or zero values. You can check if the box is empty (using `isPresent`) and retrieve its value via a get method.

Optional should be used whenever a public method might not return a value as part of normal program flow.

If you call get on an empty Optional, it will throw a `NoSuchElementException`.

It might not be immediately obvious what value Optional provides over just using null. If you need to check that an Optional has something in it before calling `get`, how is this different from checking a value is not null to avoid a `NullPointerException`?

There are several important differences.

Firstly, if your method declares that it returns `Optional<Person>` then you can instantly see from the type signature that it might not return a value. If it only returned `Person` you would only know that it might return null if you looked at the source, tests or documentation.

Equally important, if you know that you always return `Optional` within your codebase when something might not be present, then you know at a glance that a method returning `Person` will always return a value and will never return null.

Finally, the preferred way to use Optionals is not to call the get method or to explicitly check if it contains a value. Instead the values that are contained (or not contained) in an Optional can be safely  mapped, consumed and filtered by various method on the class.

In the simplest case a possibly empty Optional can be accessed by calling the `orElse` method which takes a default value to use if the Optional is empty.

As mentioned, the sweet spot for using Optionals is for the return types for methods. They should not generally be held as fields (use the null object pattern here instead) or passed to public methods (instead provide overloaded versions that do not require the parameter).

One objection that is sometimes raised by Java programmers encountering Optional for the first time is that it is possible for an Optional to be null itself. While this is true, returning a null Optional from a method is a perverse thing to do and should be considered a coding error.

Static analysis rules exists that can check for code that returns null Optionals.

### Design by Contract

We wish for all code that we control to be able to ignore the existence of null (unless it interfaces with some third party code that forces us to consider it). 

`Objects.requireNonNull` can be used to add a runtime assertion that null has not been passed to a method.

Because your core code should generally assume that null will never be passed, around there is little value in documenting this behavior with tests; assertions add value because they ensure that an error occurs close to the point where the mistake was made.

We can also check this contract at build time.

JSR-305 provides annotations that can be used to declare where null is acceptable. 

Although JSR-305 is dormant, and shows no signs of being incorporated into Java in the near future, the annotations are available at the maven co-ordinates :-

```xml
<dependency>
    <groupId>com.google.code.findbugs</groupId>
    <artifactId>jsr305</artifactId>
    <version>3.0.1</version>
</dependency>
```

They are supported by several static analysis tools including :-

* [Findbugs](http://findbugs.sourceforge.net/)
* [Error Prone](http://errorprone.info/)

These can be configured to break the build when null is passed as a parameter where we do not expect it.

Annotating every class, method or parameter with `@Nonnull` would quickly become tedious and it would be debatable whether the gain would be worth the amount of noise this would generate.

Fortunately, it is possible to make `@Nonnull` the default by annotating a package in its package-info.java file as follows

```java
@javax.annotation.ParametersAreNonnullByDefault
package com.example.somepackage ;
```

Sadly, sub-packages do not inherit their parent's annotations, so a package-info.java file must be created for each package.

Once non null parameters have been made the default behavior, any parameters that do accept null can be annotated with `@Nullable`.

