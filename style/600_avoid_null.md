## Avoid null where possible

Null is a billion dollar mistake, make sure you know how to avoid it.

Try to limit the times you or your clients need to write

```java
  if ( != null ) {
    ...
  }
```

Although it is likely that libraries and frameworks you interact with will return null, you should try and ensure that this practice is isolated to the third party code. The core of your application should assume that it does not have to worry about null values. 

Strategies include :-

* The null object pattern - when you have something you think is optional
* The type safe null pattern (aka Option, Optional & Maybe) - when you need to express that an interface might not return something
* Design by contract

### The null object pattern

The null object pattern is the classic OO approach to avoiding null. You should use it whenever you think you have a dependency that you think is optional.

The pattern is very simple, just provide an implementation of the interface that that does "nothing" or has a neutral behaviour. This can then be safely referenced by it's clients, with no need to check for null.

### Type safe nulls (Optional)

The type safe null pattern is familiar in most functional programming languages where is variously known as Maybe, Option or Optional. Java 8 finally adds an Optional type, but implementations are available for earlier versions via Guava and other libraries.

It is again a very simple pattern. An Optional is basically just a box that can hold either one or zero values. You can check if the box is empty (using isPresent()) and retrieve its value via a get method.

Optional should be used whenever a public method might not return a value as part of normal program flow.

If you call get on an empty Optional it will throw a NoSuchElementException.

It might not be immediately obvious what value Optional provides over just using null. If you need to check that an Optional has something in it before calling get, how is this different from checking a value is not null to avoid a NullPointerException?

There are several important differences.

Firstly, if your method declares that it returns Optional<Person> then you can instantly see from the type signature that it might not return a value. If it just returned Person then you would only know that it might return null if you looked at the source, tests or documentation.

As importantly if you know that within your codebase you always return Optional when something might not be present then you know at a glance that a method returning Person will always return a value and will never return null.

Finally, the preferred way to use Optionals is not to call the get method or  to explicitly check if it contains a value. Instead the values that are contained (or not contained) in an Optional can be safely  mapped, consumed and filtered by various method on the class.

In the simplest case a possibly empty Optional can be accessed by calling the `orElse` method which takes a default value to use if the Optional is empty.

As mentioned, the sweet spot for using Optionals is for the return types for methods. They should not generally be held as fields (use the null object pattern here instead) or passed to public methods (instead provide overloaded versions that do not require the parameter).

One objection that is sometimes raised by Java programmers encountering Optional for the first time is that it is possible for an Optional to itself be null. While this is true, returning a null Optional from a method is a perverse thing to do and should be considered a coding error.

Static analysis rules exists that can check for code that returns null Optionals.

### Design by contract

We wish for all code that we control to be able to ignore the existence of null (unless it interfaces with some third party code than forces us to consider it). 

Objects.requireNonNull can be used to add a runtime assertion that null has not been passed to a method.

As your core code should generally assume that null will never be passed around there is little value in documenting this behaviour with tests, but the assertions add value as they ensure that an error occurs close to the point where the mistake was made.
