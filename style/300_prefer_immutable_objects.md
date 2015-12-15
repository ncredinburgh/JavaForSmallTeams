## Prefer immutable objects

Mutable state makes programs harder to understand and maintain. If a value can be set in one place only then complexity is reduced and a subset of concurrency issues and other bugs can be avoided. For example if a object cannot be modified then you do not need to worry about its hashcode changing after it has been added to a set.

Objects representing a value should be made immutable by default, falling back to mutability when it is clearly required.

Unfortunately many Java frameworks require mutable objects that follow the bean contract. If you are working with these frameworks you will need to create mutable objects, but you should try to contain the practice to where it is needed.

The `@Immutable` annotation may be added to classes that are intended to be immutable. This communicates intent and allows static analysis to confirm if that intent has been met.
