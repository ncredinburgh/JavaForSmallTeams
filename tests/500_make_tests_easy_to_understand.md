## Make Tests Easy to Understand

One of our goals when writing a test is to document what the code under tests does.

We achieve this in part by choosing clear specification style names for each test case, but we must also ensure that the code implementing each test case is easy to understand.

Some techniques that help achieve this are discussed below.

### Make Test Structure Clear

A test can be viewed as having three parts:

* Given - create the values and objects required for the test
* When - executes the code under test 
* Then - verifies the output/behavior as as expected

These stages are also sometimes called *arrange*, *act* and *assert* by people particularly attached to the letter 'a'.

Although it is important that these three stages are visible, trying to rigorously separate them or label them with comments adds noise to a test. 

**Bad**
```java
  @Test
  public void shouldRetieveValuesInOrderTheyAreAdded() {
    
    // given
    Stack<String> testee = new Stack<String>();
    String expectedFirstValue = "a";
    String expectedSecondValue = "b";
  
    // when
    testee.push(expectedFirstValue);
    testee.push(expectedSecondValue);
    String actualFirstValue = testee.pop();  
    String actualSecondValue = testee.pop();  

    // then
    assertThat(actualFirstValue).isEqualTo(secondValue);
    assertThat(actualSecondValue).isEqualTo(firstValue);
  }
```

**Better**
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

### Follow Standard TEA Naming Convention for Test Variables

Establishing simple conventions can make some very basic things about a test clear to a reader.

If the unit you are testing is a class make this clear by always naming it `testee` within a test.

If you need to store an expected value in a variable, call it `expected` (but don't store it in a variable just for the sake of it).

If you need to store a result that you will compare against an expected value in variable, name it `actual` (but don't store it in a variable just for the sake of it).

If you have stubbed a participant consider naming it `stubbedFoo`, if it is acting as a mock name it `mockedFoo`. This rule is less hard than the others - decide on a case by case basis whether you think it makes your test more or less readable. 

### Highlight What is Important, Hide What is Not

It should be possible to read each test case at a glance - so make things clear by highlighting what is important for that test case and hiding what is not.

If an aspect of the input is important to the test case, highlight it by setting it **explicitly** in the test case - don't rely on that value being set in a generic setup method. 

Even if the same value is set by default, it is better to re-supply it in the test so it is clearly visible.

If a particular value is not important, indicate this to the reader by using well-known neutral values such as `"foo"` for strings, or use clear names such as `someInt` or `anInt` for variables and methods that supply values.

Supplying values via a method call makes them less visible.

What is important in the test below?

**Bad**
```java
  @Test
  public void shouldXXX() {
    MyClass testee = new MyClass();
    assertThat(testee.process(0, "", 3))
      .isEqualTo(Status.FAIL);
  }
```

How about this version?

**Better**
```java
  @Test
  public void shouldXXX() {
    int invalidValue = 3;
    MyClass testee = new MyClass();
    assertThat(testee.process(anInt(), aString(), invalidValue))
      .isEqualTo(Status.FAIL);
  }
  
```

While we need additional context to understand why `3` is an invalid value, it should be clear that the first two parameters to the `process` method are not important to the behavior we are specifying. 

Why is it important that the testee below returns the enum `CONTINUE`?

**Bad**
```java
  @Test
  public void shouldXXX() {
    assertThat(testee.process()).isEqualTo(CONTINUE);
  }
```

If we look through the rest of the class we might find:

```java
  @Before
  public void setup() {
     MyClass testee = new MyClass();
     testee.setDefaultProcessState(CONTINUE);
  }
```

Other tests might not need to care about what the default state is, but this test does so we should write:

**Better**
```java
  @Test
  public void shouldXXX() {
    testee.setDefaultProcessState(CONTINUE);
    assertThat(testee.process()).isEqualTo(CONTINUE);
  }
```

As we start to deal with more complex domain objects, it becomes harder to separate the important values from the ones that are required to construct valid objects but not of particular interest to our test. 
Fortunately, we can use the builder pattern to ease the pain, reduce duplication, and keep the tests readable.

### Name Values Meaningfully

If a value has an important meaning, make that meaning clear e.g.:

```java
  Foo testee = new Foo(PERFORM_VALIDATION);
```

instead of:

```java
  Foo testee = new Foo(true);
```

### Write DAMP Test Code

As we have seen, in order to highlight that a value is important to a test, we need to keep it within the test method that uses it. This may introduce duplication which we might not accept in normal code - but test code is a little different.

Copy and paste coding is bad in tests as well as production code - the more code there is, the harder it is to read and a change to a concern will result in shotgun surgery if it has been duplicated throughout the tests.

Repetition should therefore generally be avoided in test code.

Test code **is** different from production code however. 

Test code must tell more of a story - highlighting what is important and hiding what is not. Test code should not be as DRY ( **D**on't **R**epeat **Y**ourself ) as production code. It should be DAMP ( contain **D**escriptive **A**nd **M**eaningful **P**hrases ).

If refactoring a small amount of code out, a test method into a shared method hides what is happening, accept the duplication and leave it in place. If it does not affect readability then refactor mercilessly.

## Choose the Right Assertion Method

When a test fails, a good assertion tells you what is wrong. 

Although JUnit allows you to supply an assertion message this adds noise to the test. Like comments, these messages should be saved for those occasions when you cannot communicate using code alone.

Bad

```java
assertTrue("Expected 2 but got " + actual, actual == 2);
```

Good

```java
assertEquals(2, actual);
```

The built in assertions are fairly limited. Alternative assertion libraries such as AssertJ provide richer functionality and result in more readable code.

