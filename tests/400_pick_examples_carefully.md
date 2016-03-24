## Pick Examples Carefully 

Traditional testing is performed with examples.

The overall behavior of the component or unit is explained by supplying a series of example input and output values, or example interactions with other components.

Our goal is to use examples to

* Communicate the general expected behavior
* Communicate the behavior at any edge cases
* Gain confidence that our code is correct and remains correct when we change it

So how should we pick these examples?

One approach is to look at the possible inputs to the component under test. 

We could fully specify our code if we provided the expected output for each possible input. Usually, this is not practical because the possible range of inputs is far too large. Instead, we can look for categories of values within the possible of inputs (e.g *valid* and *invalid*) and pick an example from each one.

However, the best approach is usually not to think in terms of possible inputs and examples, but to instead think first of the behaviors we would like our code to exhibit.

Once we have identified the behavior we can then pick examples that demonstrate it. The actual values used are often unimportant - "Make tests easy to understand" discusses some techniques to make unimportant values less prominent in tests and highlight the important ones.

Property-based testing takes this a stage further. 

Properties are identified that must hold true for all inputs or for a subset of possible inputs that meet certain criteria. The tests do not contain any example values - just a description of how they must be constrained. The examples used to check the properties are generated randomly and only ever seen if the check fails.

There are some compelling advantages to property based testing:

* The tests describe what is important about the input values. In example testing this must be inferred by the reader
* The tests will automatically find edge cases and bad assumptions made by the programmer 

There is currently little experience with property-based testing in the Java community, so questions remain on how best to use it. 

One obvious issue is that it introduces randomness, although most frameworks provide some mechanism to control it and repeat test runs.

## Follow the Zero, One and Many Rule

If your components deals with numbers or collections of things, make sure you use sufficient examples to describe it's behavior.

A good rule thumb is that test cases covering 0 (or empty), 1 and "many" are likely to be necessary. There will also be important edge cases, e.g. algorithmic code dealing with integers might need to consider `Integer.MAX` and `Integer.MIN`.

The zero, one many rule defines the minimum number of cases you can hope to consider. To properly describe your code's behavior will likely require many more.

When test driving, it is usually easiest to start with the *zero* test case.

### Test One Thing at a Time

Each test case should specify one thing and one thing only.

Multiple assertions within a test may be an indicator that the test is testing more than one thing. Multiple assertions should be treated with suspicion, but are not necessarily a problem e.g.

```java
  @Test
  public void shouldReturnItemsInOrderTheyWereAdded() {
     ArrayDeque<String> testee = new ArrayDeque<String>();
     
     testee.add("foo");
     testee.add("bar");
     
     assertEquals("foo",testee.pop());
     assertEquals("bar",testee.pop());     
  }
```

This test tests only one concern, but uses multiple asserts to do so.

### Test Each Thing Only Once

Once you've tested a concern, don't let it leak into other tests - if you do then those tests are no longer testing only one thing.

This is a particularly easy mistake to make with interaction-based testing. If it is vitally important that the method `anImportantSideEffect` is called, it is easy to find yourself verifying that method in each test case. 

If the contract ever changes so that this side effect is not longer important, all tests will need to be updated.

This concern should instead by covered by a single test case `shouldPerformImportantSideEffect`.

Although we shouldn't let a property leak into test cases where it does not belong this does not necessarily mean that it will be confined to a single test case. It may take several examples to fully demonstrate a property.

