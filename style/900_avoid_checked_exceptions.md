## Avoid Checked Exceptions 

### Summary

Do not declare checked exceptions unless there is a clear course of action that should be taken when one is thrown.

### Details

Exceptions are for exceptional circumstances - design your code such that they are not thrown in scenarios that are expected to happen. 

This means that they should not be used for normal control flow.

Checked exceptions bloat and complicate code. You should avoid adding them to your API, except when there is a clear action that the caller can always take to recover from the error scenario. 

This is surprisingly rare.

If you are working with a library that uses checked exceptions, you can wrap them by re-throwing a runtime exception. 

When you do, be sure to maintain the stack trace.

```java
try {
  myObject.methodThrowingException();
} catch (SomeCheckedException e) {
  throw new RuntimeException(e);
}
```

If you have caught an `Exception` or a `Throwable`, so are unsure of the exact type, you can avoid creating unnecessary wrappers using Guava's `Throwables.propagate`.

```java
try {
  myObject.methodThrowingException();
} catch (Exception e) {
  throw Throwables.propagate(e);
}
```

This will wrap checked exceptions and re-throw unchecked exception as is.

