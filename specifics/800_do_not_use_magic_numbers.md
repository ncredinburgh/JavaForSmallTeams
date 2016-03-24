## Do Not Use Magic Numbers

### Summary

Magic numbers should be replaced with well-named constants that describe their meaning.

#### Detail 

Placing numeric or string literals directly into source code causes two problems:

1. It is unlikely that the **meaning** of the literal will be clear
2. If the value changes updates are required where ever the literal has been duplicated

Literals should therefore be replaced with well-named constants methods and Enums.

**Bad**
```java
public void fnord(int i) {
  if (i == 1) {
    performSideEffect();
  }
}
```

**Better**
```java
public void fnord(int i) {
  if (i == VALID) {
    performSideEffect();
  }
}
```


**You've missed the point**
```java
public void fnord(int i) {
  if (i == ONE) {
    performSideEffect();
  }
}
```

If the constants you extract relate to an identifiable concept, create an Enum instead:

**Good**
```java
public void fnord(FnordStatus status) {
  if (status == FnordStatus.VALID) {
    performSideEffect();
  }
}
```

Some coding standards make statements such as "0 and 1 are exceptions to this rule". This is, however, an oversimplification.

Sometimes 0 and 1 will have a clear local meaning as they are being used as part of low level code e.g.:

```java
  if (list.size() == 0) {...}
```

But 0 and 1 may also also have domain-specific values that should be extracted into constants like any other literal.

Server-side Java can also often be re-written in a cleaner fashion without the use of numeric literals, e.g.:

```java
  if (list.isEmpty()) {...}
```

