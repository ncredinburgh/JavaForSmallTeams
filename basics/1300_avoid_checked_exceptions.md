## Avoid checked exceptions 

Exceptions are for exceptional circumstances - design your code such that they are not thrown in scenarios that are excepted to happen. i.e. they should not be used for normal control flow.

Checked exceptions bloat and complicate code. You should avoid adding them to your api, except when there is a clear action that the caller can always take to recover from the error scenario. This is surprisingly rare.

If you are working with a library that uses checked exceptions you may wrap those exceptions by re-throwing a runtime exception. When you do so be sure to maintain the stack trace.

Guava provides a convenient utility to do this

```java
  try {
    myObject.methodThrowingException();
  } catch (SomeCheckedException e) {
    throw Throwables.propagate(e);
  }
```
