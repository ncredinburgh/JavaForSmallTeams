## Do Not Re-Assign Parameters

### Summary

Parameters to methods should never be re-assigned. 

### Detail 

Reassigning to parameters makes code harder to understand and provides no meaningful advantage over creating a new variable. 

If the method is large, it can be difficult to track the lifecycle of a parameter. Even within short methods, re-using parameters will cause problem. As the variable is being used to represent two separate concepts, it is often not possible to name it meaningfully. 

If another variable of the same type is a parameter is needed, it should be declared locally. 

**Bad**

```java
public String foo(String currentStatus) {
  if ( someLogic() ) {
    currentStatus  = "FOO";
  }
  return currentStatus;
}
```

**Better**

```java
public String foo(final String currentStatus) {
  String desiredStatus = currentStatus;
  if ( someLogic() ) {
    desiredStatus = "FOO";
  }

  return desiredStatus ;
}
```

Parameters may be declared final so that the reader can tell at a glance that its value will not change.
