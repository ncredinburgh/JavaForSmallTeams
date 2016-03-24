## Testing FAQ

### How Do I Test a Private Method?

You don't test methods (private or public), you test the behavior of a unit as a whole. 

If you cannot exercise the logic of a private method via the public interfac,e is that logic actually required? If it is required, and is sufficiently complex that it is causing you testing pain, then perhaps you should extract that concern into a separate unit that can be tested in isolation and injected in via the constructor?.

### How Do I Test a Void Method?

You don't test methods (void or not), you test the behavior of a unit as a whole. 

If the method is void, it must be performing some sort of side effect that can be checked by either state testing or interaction testing.

For example, if you are trying to 'test the add method' of collection class, you should probably instead be writing tests like:

```java
@Test
public void shouldIncreaseInSizeWhenItemsAdded() {
    Collection testee = new ArrayList();
    assertEquals(0, testee.size());
    testee.add("itemA");
    assertEquals(1, testee.size());
    testee.add("itemB");
    assertEquals(2, testee.size());
}
```

### How do I Test Code That Reasons About the Current Date/Time?

A bad solution is to use a static method (such as joda time's `setCurrentMillisFixed`) to set the current date.

A good solution is inject a strategy for retrieving the date/time into your class as a dependency. 

Java 8 provides the `java.time.Clock` class which can be used for this purpose.

The static factory method `fixed` will create an instance that represents a constant time. Other methods provide implementations suitable for production use.

Java 7 does not provide an out of the box class for this purpose so you will need to roll your own. 

### Do I Need to Implement a Teardown Method for my Test?

This used to be a requirement for all JUnit 3 tests. If you didn't nullify all members of a test class in a teardown your test suite began to eat memory as it grew.

This is not a requirement for vanilla JUnit 4 tests, but it is possible that you may need to do so if you are using a custom runner.

### What's the Difference Between Errors and Failures?

You should try to design your tests to produce **failures** when the code is logically wrong. You tests should only produce errors when something unexpected has happened.

### How Should I Test for Expected Exceptions?

It depends.

The built in:

```java
@Test(expected = FooException.class)
public void shouldThrowFooExceptionWhenFeelsLikeIt
```

Is concise and suffices for simple scenarios, but has a gotcha. If the test method exercises more than one method of the testee, the expectation applies to the whole test method rather than the specific interaction with the testee that is expected to throw it.

If data held within the exception is important, it is also not possible to assert on it with this method.

The traditional solution is to use a try catch block:

```java
@Test
public void shouldThrowFooExceptionWhenFeelsLikeIt() {
  try {
    testee.doStuff();
    fail("Expected an exception");
  } catch (FooException expectedException) {
    assertThat(expectedException.getMessage(), is("felt like it"));
  }
}
```

This is easy to follow, but a little verbose. It is also easy to forget to include the call to `fail()` if you are not test driving your code.

JUnit now provides an alternate solution in the form of the 'ExpectedException' method rule. This allows for more fine grained exception checking:

```java
@Rule
public ExpectedException thrown= ExpectedException.none();
  
@Test
public void foo() throws IOException {
  thrown.expect(FooException.class);
  thrown.expectMessage("felt like it");
    
  testee.doStuff();
}
```

This is more concise, but breaks the usual given/when/then flow of a test by moving the then part to the start of the method.

For Java 8 AssertJ provides some custom assertions that can be used without breaking this flow.

```java
@Test
public void testException() {
  assertThatThrownBy(() -> { testee.doStuff(); })
   .isInstanceOf(Exception.class)
   .hasMessageContaining("felt like it"); 
}
```
Although it maintains the flow, the lambda in which the testee is called looks a little ugly.

When it can be used we recommend sticking with the concise `expected =` format. For more complex situations it is largely a matter of taste.

### How Do I Test an Abstract Class?

An abstract class is just a dependency that some other code will use - a dependency that you have made harder than usual to isolate due to your choice to make it an abstract class.

So first off, would your design look better if the functionality was being re-used by composition rather than inheritance?

Assuming that you can't improve your design by getting rid of the abstract class you can either:

* Treat it as an implementation detail and check that each of it's clients behaves as expected.
* Test it in isolation by creating an anonymous concrete class 

The first approach will result in tests that are less tied to the implementation, but there will be repetition between the tests for each subclass.

The second approach will avoid repetition but is tied to the implementation and is likely to be brittle.

### How Do I test Hashcode and Equals?

Testing hashcode and equals can be fiddly and time consuming, which raises questions about whether it is time well spent given that the code is likely to have been auto-generated.

Equals verifier project provides a good (partial) solution:

http://www.jqno.nl/equalsverifier/

It checks that a class fulfils the hashcode-equals contract with a single line test that is trivial to write:

```java
  @Test
  public void shouldObeyHashCodeEqualsContract() {
    EqualsVerifier.forClass(MyValue.class).verify();
  }
```

It does, however, do a very thorough job of checking the contract - including how it interacts with inheritance. It is non-trivial to make a non-final class conform to the contract.

Although equals verifier does a good job of checking the hashcode equals contract, it has no knowledge of how you expect the methods to actually behave. If you wish equality to (for example) be defined by a single ID field only, you must write additional tests that verify this behavior.

For the common scenario of a class that should be considered equal based on all of its fields the behavior may be checked in a single test:

```java
  @Test
  public void shouldObeyHashCodeEqualsContract() {
    EqualsVerifier.forClass(MyValue.class).allFieldsShouldBeUsed().verify();
  }
```

This may become the default behavior in a future version of EqualsVerifier, but must be specifically specified in 1.7.5
