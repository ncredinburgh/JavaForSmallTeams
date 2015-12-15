## Methods should return data via one route only

A method should generally either return a value or produce some sort of side effect (such as updating a field or parameter) but not both.

For example

```java
  public List<String> confusing(List<String> in) {
    in.add("foo");
    return in;
  }
  
  public void sideEffecting(List<String> in) {
    in.add("foo");
  }
  
  public List<String> pure(List<String> in) {
    List<String> copy = new ArrayList<String>(in);
    copy.add("foo");
    return copy;
  }
```

Here the `confusing` method performs a side effect by modifying the list, but also returns the list causing confusion. Changing the signature to void makes the method less confusing.

The form demonstrated in `pure` should be generally preferred. Pure functions are easier to reason about and re-use.

Ideally the only side effects a method should perform is to act on the state owned by the class - i.e its fields. Updating the state of parameters as shown in the first two examples should be discouraged, especially in public methods.

Some coding guides state that a method should have only a single return statement. This is bad advice for Java as discussed  in "ignore single return rules".
