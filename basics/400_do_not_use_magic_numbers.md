## Do not use magic numbers

Replace magic numbers (and magic strings) with well named constants that describe what they mean

Bad
```java
  public void fnord(int i) {
    if (i == 1) {
      performSideEffect();
    }
  }
```

Better
```java
  public void fnord(int i) {
    if (i == VALID) {
      performSideEffect();
    }
  }
```


You've missed the point
```java
  public void fnord(int i) {
    if (i == ONE) {
      performSideEffect();
    }
  }
```

If the constants you extract relate to an identifiable concept, create an Enum instead

Good
```java
  public void fnord(FnordStatus status) {
    if (status == FnordStatus.VALID) {
      performSideEffect();
    }
  }
```
