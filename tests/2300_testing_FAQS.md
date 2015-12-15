## Testing FAQs

### How do I test a private method?

You don't test methods (private or public), you test the behaviour of a unit as a whole. 

If you cannot exercise the logic of a private method via the public interface is that logic actually required? If it is required and is sufficiently complex that it is causing you testing pain, then perhaps you should extract that concern into a separate unit that can be tested in isolation and injected in via the constructor?.

### How do I test a void method?

You don't test methods (void or not), you test the behaviour of a unit as a whole. 

If the method is void it must be performing some sort of side effect that can be checked by either state testing or interaction testing.

For example if you are trying to 'test the add method' of  collection class, you should probably instead be writing tests like :-

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

### How do I test code that reasons about the current date/time?

A bad solution is to use a static method (such as joda time's `setCurrentMillisFixed`) to set the current date.

A good solution is inject a strategy for retrieving the date/time into your class as a dependency. 

### Do I need to implement a teardown method for my test?

This used to be a requirement for all JUnit 3 tests. If you didn't nullify all members of a test class in a teardown your test suite began to eat memory as it grew.

This is not a requirement for vanilla JUnit 4 tests, but it is possible that you may need to do so if you are using a custom runner.

### What's the difference between errors and failures?

You should try to design your tests to produce **failures** when the code is logically wrong. You tests should only produce errors when something unexpected has happened.

### How should I test for expected exceptions?

It depends.

The built in :-

```java
@Test(expected = FooException.class)
public void shouldThrowFooExceptionWhenFeelsLikeIt
```

Is concise and suffices for simple scenarios, but has a gotcha. If the test method exercises more than one method of the testee the expectation applies to the whole test method, rather than the specific interaction with the testee that is expected to throw it.

If data held within the exception is important it is also not possible to assert on it with this method.

The 'ExpectedException' method rule allows for more specific exception checking, but care must be taken when using it with customer runners as this may result in false positives.

The simple approach of

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

May be preferable for these reasons, or the https://code.google.com/p/catch-exception/ library may provide a cleaner solution.

### How do I test an abstract class?

An abstract class is just a dependency that some other code will use - a dependency that you have made harder than usual to isolate due to your choice to make it an abstract class.

So first off, would your design look better if the functionality was being re-used by composition rather than inheritance?

Assuming that you can't improve your design by getting rid of the abstract class you can either

* Treat it as an implementation detail and check that each of it's clients behaves as expected.
* Test it in isolation by creating an anonymous concrete class 

The first approach will result in tests that are less tied to the implementation, but there will be repetition between the tests for each subclass.

The second approach will avoid repetition but is tied to the implementation and is likely to be brittle.

### How do I test hashcode and equals?

Testing hashcode and equals can be fiddly and time consuming, raising questions about whether it is time well spent given that the code is likely to have been auto-generated.

Equals verifier project provides a good (partial) solution

http://www.jqno.nl/equalsverifier/

It checks that a class fulfils the hashcode-equals contract with a single line test that is trivial to write.

```java
  @Test
  public void shouldObeyHashCodeEqualsContract() {
    EqualsVerifier.forClass(MyValue.class).verify();
  }
```

It does however do a very thorough job of checking the contract - including how it interacts with inheritance. It is non-trivial to make a non final classes conform to the contract.

Although equals verifier does a good job of checking the hashcode equals contract, it has no knowledge of how you expect the methods to actually behave. If you wish equality to (for example) be defined by a single id field only, you must write additional tests that verify this behaviour.

For the common scenario of a class that should be considered equal based on all of its fields the behaviour may be checked in a single test.

```java
  @Test
  public void shouldObeyHashCodeEqualsContract() {
    EqualsVerifier.forClass(MyValue.class).allFieldsShouldBeUsed().verify();
  }
```

This may become the default behaviour in a future version of EqualsVerifier, but must be specifically specified in 1.7.5
