## Group Methods for Easy Comprehension

### Summary

The public methods of a class should appear at the top of the file, the private methods towards the bottom and any protected or package default methods in between.

In addition to arranging by accessibility, they should also be ordered into a logical flow. 

### Detail 

This scheme tries to achieve two goals:

1. Highlight the public API by separating it from implementation detail
2. Allow the reader to follow the logical flow with the minimal of scrolling

To achieve the 2nd goal, methods should be arranged into logical groups, with methods always appearing above the ones they call. 

The two goals clearly conflict because grouping the public API methods together the top of the file prevents grouping them with the implementation methods that they used. If this causes a large problem it may be an indication that the class has too many responsibilities and could be refactored into one or more smaller classes. 

Questions of the "correct" location of a method will also occur when a implementation method is called from multiple locations or methods have recursive relationships. There is, of course, no one right answer and any ordering that broadly meets the second goal may be used.

Constructors and static factory methods should usually be placed first in the class. The fact that a method is static should not, however, generally influence where it is placed.

**Example**

```java
public class Layout {
  Layout() {...}
  
  public static Layout create() {...}
  
  public void api1() {
    if (...) {
      doFoo();
    }
  }
  
  public void api2() {
    if(...) {
      doBar();
    }
  }
  
  private void doFoo() {
    while(...) {
      handleA();
      handleB();
    }
    leaf();
  }
  
  private void handleA() {...}
  
  private void handleB() {...}
  
  private static void doBar() {
    if (...) {
      leaf();
    }
  }
  
  private void leaf() {...}  
}

```
