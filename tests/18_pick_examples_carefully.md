## Pick examples carefully 

Traditional testing is performed by creating examples.

The overall behaviour of the system, component or unit is explained by supplying a series of example input and output values and interactions with other components.

Although examples are used to communicate the system behaviour, it is important to understand that the examples are just a means to an end.

Instead of thinking in terms of examples, we should think first of property of the system that we wish to describe, then think of the examples we can use to demonstrate this properties.

### Test one thing at a time

Each test case should specify one property and one property only.

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

### Test each property only once

Once you've tested a concern don't let it leak into other tests - if you do those tests are no longer testing only one thing.

This is a particularly easy mistake to make with interaction based testing. If it is vitally important that the method `anImportantSideEffect` is called, it is easy to find yourself verifying that method in each test case. 

If the contract ever changes so that this side effect is not longer important, all tests will need to be updated.

This concern should instead by covered by a single test case `shouldPerformImportantSideEffect`.

Although we shouldn't let a property leak into test cases where it does not belong this does not necessarily mean that it will be confined to a single test case. It may take several examples to fully demonstrate a property.

## Follow the Zero, One and Many rule

If your components deals with numbers or collections of things, make sure you use sufficient examples to describe it's behaviour.

A good rule thumb is that test cases covering 0 (or empty), 1 and "many" are likely to be necessary. There will also be important edge cases, e.g. algorithmic code dealing with integers might need to consider `Integer.MAX` and `Integer.MIN`.

The zero, one many rule defines the minimum number of cases you can hope to consider. To properly describe your code's behaviour will likely require many more.

When test driving it is usually easiest to start with the *zero* test case.
