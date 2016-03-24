## Keep It SOLID

### Summary

The SOLID acronym provides some guidance on design that you should follow.

* **S**ingle Responsibility Principle
* **O**pen Closed Principle
* **L**iskov Substitution Principle
* **I**nterface Segregation Principle
* **D**ependency Inversion Principle

### Details

#### Single Responsibility Principle

Separate your concerns - a class should do one thing and one thing only. To put it another way, a class should have a single reason to change.

#### Open / Closed Principle

You should be able to extend behavior, without modifying existing code.

*".. you should design modules that never change. When requirements change, you extend the behavior of such modules by adding new code, not by changing old code that already works."*

*— Robert Martin*

An indication that you might not be following this principle is the presence of `switch` statements or `if/else` logic in your code.

#### Liskov Substitution Principle

Derived classes must be substitutable for their base classes.

One indication that you are breaking this principle is the presence of `instanceof` statements in your code.

#### Interface Segregation Principle

The Interface Segregation Principle states that clients should not be forced to implement interfaces they don't use; prefer small, tailored interfaces to large, catch-all ones.

One indication that you might be breaking this principle is the presence of empty methods or methods throwing `OperationNotSupportedException` in your code.

#### Dependency Inversion Principle

High-level modules should not depend upon low-level modules. Both should depend upon abstractions.

Abstractions should never depend upon details. Details should depend upon abstractions.

In practice this means you should follow one of two patterns:

1. Package the interfaces a 'high-level' component depends upon with that component
2. Package the interface a component depends upon separately from both the client and implementation

This first approach is classic dependency inversions (contrast it with the traditional approach of have the high level component depend upon the lower layers).

The second approach is known as the "Separated Interface Pattern". It is a little more heavy weight, but also more flexible as it makes no assumption about who should own the interface.

An indication that you are breaking this principle is the presence of package cycles within your code.

