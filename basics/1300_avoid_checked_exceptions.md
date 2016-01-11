## Avoid checked exceptions 

### Summary

Do not declare checked exceptions unless there is a clear course of action that should be taken when one is thrown.

### Details

Exceptions are for exceptional circumstances - design your code such that they are not thrown in scenarios that are expected happen. 

This means that they should not be used for normal control flow.

Checked exceptions bloat and complicate code. You should avoid adding them to your api, except when there is a clear action that the caller can always take to recover from the error scenario. This is surprisingly rare.

If you are working with a library that uses checked exceptions you may wrap them by re-throwing a runtime exception. 

When you do so be sure to maintain the stack trace.

Guava provides a convenient utility to do this

```java
try {
  myObject.methodThrowingException();
} catch (SomeCheckedException e) {
  throw Throwables.propagate(e);
}
```
