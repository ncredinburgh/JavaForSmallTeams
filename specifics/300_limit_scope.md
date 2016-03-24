## Limit Variables to the Smallest Possible Scope

### Summary

Variables should be declared as late as possible so that they have the narrowest possible scope.

### Details

*Bad*

```java
public void foo(String value) {
    String calculatedValue;
    if (someCondition()) {
        calculatedValue = calculateStr(value);
        doSomethingWithValue(calculatedValue);
    }
}
```

*Better*

```java
public void foo(String value) {
    if (someCondition()) {
        String calculatedValue = calculateStr(value);
        doSomethingWithValue(calculatedValue);
    }
}
```

*Better still*

```java
public void foo(String value) {
    if (someCondition()) {
        doSomethingWithValue(calculateStr(value));
    }
}
```

Sometimes, assigning to well-named, temporary variables will result in more readable code than calling a method inline because it helps the reader follow the data and logical flow.

As a rule of thumb, if you are unable to come up with a name for a variable that does little more than mirror a method from which its value was retrieved, then the variable should be eliminated.

