## Don't Use the Assert Keyword

### Summary

Assertions are a useful coding technique that can provide many benefits but in most circumstances it is better to implement them using third party libraries rather than the `assert` keyword.

### Details

Assertions written with the assert keyword are only enabled when the `-ea` JVM flag is set.

The intent of this flag is to allow the assertions to be enabled in development and testing but disabled in production to avoid the performance overhead of assertion logic. This is usually a premature optimization and increases the opportunity for mistakes as the code will behave differently in development vs production.

Switching off assertions in production also greatly dilutes their value. If a coding error has been made assertions ensure that it is reported early, close to the bug. If assertions are turned off in production bugs may propagate silently. This may make their consequences more severe and will certainly make the issue harder to diagnose.

So for these reasons, unless you are working in a very performance sensitive domain, assertions should always be enabled.

For always-on assertions third party libraries such as Guava's preconditions provide a better solution than the `assert` keyword.

A separate issue is the use of the `assert` keyword in tests. This is usually the result of a lack of familiarity with Java and JUnit.

In codebases found in the wild where `assert` has been used in tests the `-ea` flag is rarely set, meaning that the tests can never fail. For tests JUnit's built in assertions or modern test focused assertion libraries such AssertJ should always be used.
