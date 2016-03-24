## Prefer Maps and Filters to Imperative Loops

### Summary

Imperative loops hide application logic inside boilerplate code - prefer maps and filters as these separate the logic from the implementation. 

### Details

Most loop based code can be re-written in a more declarative style using filters and maps.

Java 8 made this easy by introducing lambdas and the streams API, but the same style can be applied in Java 7 using anonymous inner classes and third party libraries such as Guava.

Filters and maps highlight what the code is intended to achieve. This is less clear in the imperative implementation.

**Bad**
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

**Better (Java 8)**
```java
  public List<String> selectValues(List<Integer> someIntegers) {
    return someIntegers.stream()
        .filter(i -> i > 20)
        .map(i -> i.toString())
        .collect(Collectors.toList());
  }
```

**Better (Java 7 using Guava)**
```java
  public List<String> selectValues(List<Integer> someIntegers) {
    return FluentIterable
    .from(someIntegers)
    .filter(greaterThan(20))
    .transform(Functions.toStringFunction())
    .toList();
  }

  private static Predicate<Integer> greaterThan(final int limit) {
    return new Predicate<Integer>() {
      @Override
      public boolean apply(Integer input) {
        return input > limit;
      }
    };
  }
```

Note that, although the Java 7 version requires more lines of code (in the form of the ugly boilerplate for the anonymous inner class), the logic of the `selectValues` method is clearer. If the logic required in the Predicate or mapping Function is required in multiple places then it is straightforward to move this to a common location. This is harder to achieve with the imperative version.

Also note that the method that creates the Predicate has been made static. It is a good idea to do this, where possible, when returning an anonymous class to prevent a long lived instance preventing the parent class from being garbage collected. Although the Predicate is only short-lived in this instance, applying static dogmatically in all cases avoids the overhead of thinking.
