## Prefer For-Each Loops to For Loops

### Summary

Use `for each` loops in preference to indexed for loops.

### Details

The `for each` loop introduced with Java 5 avoids the potential out-by-one errors of indexed for loops and is more concise than code using iterators.

*Bad*
```java
  public List<String> selectValues(List<Integer> someIntegers) {
    List<String> filteredStrings = new ArrayList<String>();
    for (int i = 0; i != someIntegers.size(); i++) {
      if (value > 20) {
        filteredStrings.add(value.toString());
      }
    }
    return filteredStrings;
  }
```
  
*A little better*
```java
  public List<String> selectValues(List<Integer> someIntegers) {
    List<String> filteredStrings = new ArrayList<String>();
    for (Integer value : someIntegers) {
      if (value > 20) {
        filteredStrings.add(value.toString());
      }
    }
    return filteredStrings;
  }
```
