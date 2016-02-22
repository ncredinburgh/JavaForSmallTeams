## Test one thing at a time

Each test method should test one 'thing' and one 'thing' only.

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
