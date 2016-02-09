## Single exit point rules

### Summary

There is nothing inherently wrong with code that contains more than one return statement.

### Details

Some coding standard mandate that all methods should have a single exit point.

This may have made sense historically for languages that work at a lower level than Java, but for Java it makes no sense. Trying to apply this "best practice" often results in the need to introduce additional local variables to hold return state, nested conditional statements and other bloat.

**Overly complex**
```java
public class Example {
  private int value;

  public int complex(int x) {
    int retVal = 0;
    if (x > 0) {
      retVal = value + x;
    } else if (x == 10) {
      retVal = retVal - value;
    }
    return retVal;
  }

}
```

**Simpler**
```java
public class Example {
  private int value;

  public int simpler(int x) {
    if (x <= 0) {
      return 0;
    }
    if (x == 10) {
      return -value;
    }
    return value + x;
  }

}
```

Unfortunately many static analysis tools supply a rule to check for single exit, though most disable it by default.

