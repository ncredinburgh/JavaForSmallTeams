## Choose the right assertion method

When a test fails a good assertion tells you what is wrong. 

Although JUnit allows you to supply an assertion message this adds noise to the test. Like comments these messages should be saved for those occasions when you cannot communicate using code alone.

Bad

```java
assertTrue("Expected 2 but got " + actual, actual == 2);
```

Good

```java
assertEquals(2, actual);
```

The built in assertions are however fairly limited. Alternative assertion libraries such as AssertJ provides richer functionality and result in more readable code.
