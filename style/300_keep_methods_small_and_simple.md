## Keep Methods Small and Simple

### Summary

Keep methods small and simple.

### Details

Small things are easier to understand than big things. Methods are no different.

One way to measure the size of a method is via the number of lines of code it contains.

As a guide methods should not usually be longer than 7 lines in length. This is not a hard rule - just a guide of when to feel uncomfortable with a method's size. 

Another way to gauge the size of a method is to see how many possible paths there are through it. The *Cyclomatic complexity* of a method gives a measure of this - it will increase as the amount of conditional logic and number of loops grows.

As a guide, methods should not usually have a complexity above 5. Again, this is not a hard rule, just a guide of when to feel uncomfortable.

Your code will naturally contain some methods that are larger than others - some concepts are inherently more complex than others and the implementation will not become simpler if broken down further or expressed in a different way.

But most large methods can be made smaller in one of three ways :

* Refactoring into a number of smaller methods
* Re-expressing the logic  
* Using appropriate language features

#### Splitting a Method into Smaller Concerns

Many large methods have smaller methods within them trying to find a way out.

We can make our code easier to maintain by freeing them.

**Bad**

```java
protected static Map<String, String> getHttpHeaders(HttpServletRequest request) {
  Map<String, String> httpHeaders = new HashMap<String, String>();

  if (request == null || request.getHeaderNames() == null) {
    return httpHeaders;
  }

  Enumeration names = request.getHeaderNames();

  while (names.hasMoreElements()) {
    String name = (String)names.nextElement();
    String value = request.getHeader(name);
    httpHeaders.put(name.toLowerCase(), value);
  }

  return httpHeaders;
}
```

**Better**

```java
protected static Map<String, String> getHttpHeaders(HttpServletRequest request) {
  if ( isInValidHeader(request) ) {
    return Collections.emptyMap();
  }
  return extractHeaders(request);
}

private static Map<String, String> extractHeaders(HttpServletRequest request) {
  Map<String, String> httpHeaders = new HashMap<String, String>();
  for ( String name : Collections.list(request.getHeaderNames()) ) {
    httpHeaders.put(name.toLowerCase(), request.getHeader(name));
  }
  return httpHeaders;
}

private static boolean isInValidHeader(HttpServletRequest request) {
  return (request == null || request.getHeaderNames() == null);
}
```

#### Re-expressing logic

**Terrible**
```java
public boolean isFnardy(String item) {
  if (item.equals("AAA")) {
    return true;
  } else if (item.equals("ABA")) {
    return true;
  } else if (item.equals("CC")) {
    return true;
  } else if (item.equals("FWR")) {
    return true;
  } else {
    return false;
  }
}
```

This can be easily re-expressed with less noise as :

**Better**
```java
public boolean isFnardy(String item) {
  return item.equals("AAA")
      || item.equals("ABA")
      || item.equals("CC")
      || item.equals("FWR");
}
```

Or with a move to a more declarative style :

```java
private final static Set<String> FNARDY_STRINGS 
  = ImmutableSet.of("AAA", 
                    "ABA", 
                    "CC", 
                    "FWR");

public boolean isFnardy(String item) {
  return FNARDY_STRINGS.contains(item);
}
```

Neither of the above changes alter the structure of our program or even affect the signature of the method. Both still reduce both line count and complexity while increasing readability.

Simplifying things with a series of higher impact changes that extract a model of our domain is, however, often the best approach.

It is difficult to guess what this model might look like for our contrived example, but is likely that this conditional logic could be replaced with polymorphism.

```java
enum ADomainConcept {
  AAA(true), 
  ABA(true), 
  CC(true), 
  FWR(true), 
  OTHER(false),
  ANDANOTHER(false);
  
  private final boolean isFnardy;
  private ADomainConcept(boolean isFnardy) {
    this.isFnardy = isFnardy;
  }
  
  boolean  isFnardy() {
    return isFnardy;
  }
}
```

#### Using Appropriate Language Features

Methods are sometimes bloated by boilerplate that solves common programming problems. The need for some of this boilerplate has been removed by new language features. 

Some of these *new* features aren't all that new, but code is still written without them:

* Java 5 Generics removes the need for ugly casts
* The Java 5 for-each-loop can replace code using iterators and indexed loops
* The Java 7 try-with-resources can replace complex try, catch finally blocks
* The Java 7 multi-catch can replace repeated catch blocks
* Java 8 lambda expressions can replace anonymous class boilerplate

