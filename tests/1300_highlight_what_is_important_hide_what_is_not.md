## Highlight what is important, hide what is not

It should be possible to read each test case at a glance - so make things clear by highlighting what is important and hiding what is not.

If an aspect of the input is important to the test case highlight it by setting it **explicitly** in the test case - don't rely on that value being set in a generic setup method. 

Even if the same value is set by default, it is better to resupply it in the test so it is clearly visible.

If a particular value is not important indicate this to the reader by using well known neutral values such as `"foo"` for strings, or use clear names such as `someInt` or `anInt` for variables and methods that supply values.

Supplying values via a method call makes them less visible.

In the example below, while we need additional context to understand why `3` is an invalid value, it should be clear the first to parameters to the `process` method are not important to the behaviour we are specifying. 

```java
  @Test
  public void shouldXXX() {
    int invalidValue = 3;
    MyClass testee = new MyClass();
    assertThat(testee.process(anInt(), aString(), invalidValue))
      .isEqualTo(Status.FAIL);
  }
  
```

Using the builder pattern can help make the setup of data more readable.
