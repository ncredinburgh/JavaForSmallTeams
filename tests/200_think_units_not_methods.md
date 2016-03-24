## Think Units, Not Methods

Each behavior that a unit test describes should normally relate to the overall *unit* rather than the responsibilities of an individual method. 

### What is a Unit?

To think in terms of units we have to first answer the difficult question of what a *unit* actually is.

Testing in terms of methods is effectively the same as saying that a *unit* is a method. It is easy to show why this does not always work.

If we were to try and write a unit test for the `push` method of `java.util.Stack` we might end up with something like:

```java
@Test
public void testPush() {
   Stack<String> testee = new Stack<String>();
   testee.push("foo");
   assertThat(testee.pop()).isEqualTo("foo");
};
```

Now lets test the `pop` method:

```java
@Test
public void testPop() {
   Stack<String> testee = new Stack<String>();
   testee.push("foo");
   assertThat(testee.pop()).isEqualTo("foo");
};
```

Oh. That looks familiar.

The problem we are hitting is that we have defined too small a *unit*. We are trying to describe the behavior of something that is only useful when it collaborates with other *units* of the same size.

If we start thinking of `java.util.Stack` as our *unit* then tests become much easier to write:

```java
@Test
public void shouldRetieveValuesInOrderTheyAreAdded() {
  Stack<String> testee = new Stack<String>();
  testee.push("a");
  testee.push("b");
  assertThat(testee.pop()).isEqualTo("b");
  assertThat(testee.pop()).isEqualTo("a");
}
```

We have written a test that, instead of trying to describe what a method does, describes the behavior of the class as a whole.

The idea that our job is to test methods is common with developers that are new to unit testing, and is unfortunately re-enforced by some IDEs and tools that provide templates to generate tests for each method of a class.

As we have seen, for `Stack` it makes far more sense to consider the behavior of the class of a whole.

### Are Classes Units?

It often does make sense to treat a class as a *unit* so this is a good default definition, but it isn't always the right granularity.

If we were to try to test the `java.util.Collections` class we would find that it is perfectly reasonable to treat the `sort`, `reverse` , `singleton`, etc. methods as separate *units*. Each one represents a self contained logical behavior.  

So sometimes *units* are as small as methods.

Sometimes they are also larger than a single class.

If we were to inherit the code below without any tests what tests might we write for it?

```java
public class ThingaMeBob {
  
  private final Iterable<MatchingBinaryOperator> actions;
 
  ThingaMeBob() {
    actions = Arrays.asList(new Addition(), new Subtraction());
  }

  public int process(String s, int a, int b) {
    for (MatchingBinaryOperator each : actions) {
      if (each.match(s)) {
        return each.apply(a,b);
      }
    }
    
    throw new RuntimeException();
  }
    
}

class Addition implements MatchingBinaryOperator {
  public boolean match(String s) {
    return "add".equals(s);
  }
  public int apply(int a, int b) {
    return a + b;
  }
}

class Subtraction implements MatchingBinaryOperator {
  public boolean match(String s) {
    return "minus".equals(s);
  }
  public int apply(int a, int b) {
    return a - b;
  }
}

```

We might write tests for the Addition and Subtraction classes:

```java
public class AdditionTest {
  
  Addition testee = new Addition();
  
  @Test
  public void shouldMatchWhenStringIsAdd() {
  }
  
  @Test
  public void shouldNotMatchWhenStringIsNotAdd() {
  }
  
  @Test
  public void shouldAddTwoNumbers() {
  }
  
  // etc

}
```

And for the `ThingaMeBob` class:

```java
public class ThingaMeBobTest {
  
  ThingaMeBob testee = new ThingaMeBob();

  @Test
  public void shouldAddTwoNumbers() {
  }
  
  @Test
  public void shouldSubtractTwoNumbers() {
  }

  // etc
  
}

```

At some point we would hopefully question why this code is so over-engineered and consider refactoring to something simpler like.

```java
public class ThingaMeBob {

  public int process(String s, int a, int b) {
    if ("add".equals(s)) {
      return a + b;
    }
    
    if ("minus".equals(s)) {
      return a - b;
    }
    
    throw new RuntimeException();
  }
    
}
```

What happens to our tests?

Which ones were most valuable?

The answer of course is that the test which exercised all three classes through the public interface of `ThingaMeBob` proved the most useful. We did not have to change it at all. When it ran green we knew our refactoring was successful and everything still works.

We deleted the ones for `Addition` and `Subtraction`. The smaller units we created were just implementation detail.

Lets re-wind and imagine things happened differently. 

What if we were asked to test drive the desired behavior from scratch? What would we write?

We would most likely write something that looked like our 2nd simpler version of `ThingaMeBob` and a test that looked something like `ThingAMeBobTest`.

If we were then asked to add support for another 10 operations, we might leave our design fundamentally the same.

What if a new requirement came for the behavior in `ThingAMeBob` to be more dynamic, with different operations being enabled and disabled at runtime?

It would then make sense to refactor to something like our earlier more complex version.

What should we do with the tests?

We would already have tests written in terms of `ThingaMeBob` that describe all supported behaviors. Should we also fully describe `Addition`, `Subtraction` and the other 10 operations with tests as we extract them into classes?

There is no right answer here, but I hope it is clear that the most most useful *unit* that we have identified is `ThingaMeBob`. The smaller *units* are part of just one implementation of the functionality we require.

If we choose to write tests for each extracted class those tests would have some value. 

The test written in terms of `ThingaMeBob` would do a poor job of describing what each of the small extracted units does. If a test was failing it wouldn't be instantly obvious which class the bug was in. If we had to change one of the extracted classes it wouldn't be instantly obvious which test to run.

So there is definitely value in writing tests for each of the extracted classes. At the same time, if we were not to do so, that would also be a reasonable decision and it would reduce the cost of the refactoring.

The `ThingaMeBob` tests will be fast and repeatable and allow us to work easily with the code. If we could only have tests at one level, the level we would choose is `ThingaMeBob`.

So, as a starting point, assume that a *unit* will be a class, but recognize that this is not a hard rule.

A *unit* is really a "single self contained logical concern" - it may make sense to have several classes collaborate in order to capture that concern - as long as that collaboration provides a single well defined entry point.

Making units too small may be a form of over-specifying.

Making units too large may result in tests that are difficult to understand and expensive to maintain.

As a rule of thumb, if you might reasonably have made one or more classes inner classes of a different class, perhaps they should be treated as a single unit.
