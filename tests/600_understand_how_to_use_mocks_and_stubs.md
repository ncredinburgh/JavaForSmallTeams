## Understand How to Use Mocks and Stubs

There are two sorts of code and they require two different sorts of test.

**Worker code** does stuff. We can test worker code with **state based testing** - i.e. asserting that expected values are returned from methods, or objects are left in expected states.

State based testing is easily recognized as it will use assert statements.

**Manager code** does stuff by co-coordinating others. 

Manager code is harder to test than worker code because we need to make a choice - do we try to infer its behavior from its outputs using state based testing, or do we use **interaction based testing**?

In interaction based testing, we check that objects talk to each other in the expected fashion. To do this we need to somehow eavesdrop on the conversation. This is achieved by using objects that impersonate real ones.

Usually these are created using a mocking framework.

### Mocking Frameworks

Although it is common to refer to all objects created by a mocking framework this is inaccurate.

A more correct generic term for these objects is *test double*.

These can be subdivided based on they behave:

* Dummy object - needs to be present to satisfy a type signature but is never actually used
* Stub - must be present and may supply *indirect inputs*
* Mock - verifies that expected interactions take place
* Fake - like a real thing but less heavy - e.g in memory database
* Spy  - object that records its interactions with others

Of these only stubs, mocks and spies might be created by a mocking framework.

We will talk about spies in a moment, but most test doubles can be conceptually viewed as being either a stub or a mock.

The important difference between them is that a mock has an expectation that will cause a test to fail if it is not met. i.e. if an expected method is not called on a mock the test will fail. 

A stub does not care if it is called or not - it's role is simply to supply values.

Traditional Mocks present a code readability dilemma. They define an expected outcome (a *then*), but are also part of the fixture required for the test to execute (a *given*).

For example with JMock we would write:

```java
  Mockery context = new Mockery(); 
 
  // given / arrange
  Subscriber subscriber = context.mock(Subscriber.class);
  Publisher publisher = new Publisher();
  publisher.add(subscriber);
        
  final String message = "message";
 
  // then / assert . . . but we haven't had a when yet      
  context.checking(new Expectations() {{
    oneOf (subscriber).receive(message);
  }});

  // when / act
  publisher.publish(message);
       
  // then / assert
  context.assertIsSatisfied();
```

Spies solve this problem neatly.

### Spies

Spies record their interactions with other objects.

In practice this means that Spies act as stubs by default, but as mocks when we want them to.

The given/when/then flow becomes easy and natural to maintain.

For example, using Mockito:

```java
  // given
  Subscriber subscriber = Mockito.mock(Subscriber.class);
  Publisher publisher = new Publisher();
  publisher.add(subscriber);
  String message = "message";
  
  // when
  publisher.publish(message);
    
  // then
  Mockito.verify(subscriber).receive(message); 
```

For this reason we recommend using a spy framework. 

When spies act as mocks that must also supply indirect inputs, it is best to make them as forgiving as possible when supplying values but as specific as possible when verifying.

What does this mean?

Lets imagine that, for some reason, the subscribers in our example had to return a positive integer in order for the code to execute without error. Perhaps there is some sort of assert statement in the code:

```java
public interface Subscriber {
  int receive(String message);
}
```

We could ensure our test passed as follows: 

```java
  String message = "amessage";
  Subscriber subscriber = Mockito.mock(Subscriber.class);
  // inject indirect value 
  Mockito.when(subscriber.receive(message)).thenReturn(1);

  Publisher publisher = new Publisher();
  publisher.add(subscriber);
    
  publisher.publish(message);
    
  Mockito.verify(subscriber).receive(message); 
```

We will not discuss the Mockito API in any detail here, but this line:

```java
  Mockito.when(subscriber.receive(message)).thenReturn(1);
```

Ensures that when the `receive` method is called on the spy with a string that equals the `message` variable, it will return `1`. 

If this line was not present the spy would do what Mockito does by default, which is to return `0`.

What would our test do if, due to a bug, receive was called with a different string?

The answer is that, instead of failing due to the verification:

```java
    Mockito.verify(subscriber).receive(message); 
```

It would throw an error before it reached this point because the assertion in our production code would trigger.

We were too specific.

If we instead setup our spy as follows

```java
    Mockito.when(subscriber.receive(anyString())).thenReturn(1);
```

The test would fail cleanly.

This pattern of being lenient when supplying values, but specific when verifying also tends to result in tests that are less brittle when things change.

### Stubs in State-Based Tests

By definition, state-based testing will never include mocks (in the strict sense of the word), but they may use stubs to supply indirect values.

It can be tempting to use a mocking framework to create stub values for state based tests. For complex objects this can appear easier than constructing real ones.

Don't do this.

Mocking frameworks should be used only to isolate our tests from objects with behavior. If you have values that are difficult to construct consider the test data builder pattern instead·

### Choosing Between State and Interaction Testing

Sometimes there is no choice about which to use. For example, it is not possible to meaningfully specify how a cache should behave from its inputs and outputs alone. Other times we must weigh the pros and cons.

A state-based test for manager code is likely to be less easy to read and understand as it must rely on the behaviors of the objects the SUT interacts with. The test will also be coupled to these behaviors and may require changes if those behaviors change - you have effectively increased the size of the "unit" you are testing as discussed in "Think units nots methods".

Interaction-based testing requires us to peek beyond the unit's external interface and into its implementation. This carries the risk that we might over-specify and create an implementation-specific test.

On balance, it is preferable to lean towards state based testing and where possible enable it in the design of your code. There will, however, be many situations in which you will decide that interaction based testing is preferable.

