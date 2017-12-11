## Know common one liners

### Summary

The JDK contains a number of utility functions that should be used to replace more verbose code.

### Details

As discussed in "Optimize for Readability not Performance" we should prefer simple code to more complex code that we think might be more efficient (unless we have demonstrated that the more complex code has a real benefit via profiling and performance testing).

Sometimes however we find ourself in the happy situation where we do not need to make a trade off between the clarity of our code and (presumed) performance. Sometimes there is also reason to believe that cleanest version of the code might also be slightly more efficient.

There are a number of small functions scattered around the JDK that are both cleaner than the code they are commonly used to replace, and also possible slightly more efficient. These should be used whenever possible, and once you know they are there any code that doesn't use them looks will look slightly wrong.

Most IDEs will prompt you to use some or all of these one liners.

## java.util.Arrays.asList

For when you need to convert an array to a fixed size list.

List<String> ss = Arrays.asList(“1”, “2”);

This is cleaner and more efficient than the commonly seen alternatives such as:

List<String> ss = new ArrayList<>();
ss.add(“1”);
ss.sdd(“2”);

The list implementation returned by `asList` is specialized and may consume slightly less memory than an ArrayList.

Be aware that the lists created by this method are not fully immutable. They are fixed size and will throw a java.lang.UnsupportedOperation if you try to add or remove members, but modifying methods such as `set` will succeed.

If you are working with Java 9 the `List.of` methods provide a superior alternative.

## java.util.Collections.empty*

The `java.util.Collections` class contains methods that create unmodifiable versions of the common collections classes specialized to contain either no entries or single entries.

The most common ones are:

* `emptyMap`
* `emptyList`
* `emptySet`
* `singletonList`
* `singletonMap`
* `singletonSet`

But there are other more specialized methods there as well.

Again, using these results in cleaner more descriptive code compared to the common alternatives and the specialized data structures returned may have a slightly smaller footprint.

If you are working with Java 9 the static `of` methods provide a superior alternative to the single entry methods.

## valueOf

The form:

```java
Boolean b = Boolean.valueOf(true);
```

Is slightly more efficient than the subjectively uglier:

```java
Boolean b = new Boolean(true);
```

`valueOf` will return one of two fixed Boolean instances while calling the constructor will always allocate a new object.

Similarly for Integers `valueOf` will return a shared instance for values between -128 and 127.

`Long.valueOf` will similarly return objects from a cache.

The Oracle JDK does not currently look to use a cache for Floats or Doubles when calling `valueOf`. So using `valueOf` in preference to new for floating points might not have an advantage, but it has no disadvantage either.

Overloaded versions of the `valueOf` methods construct their desired types from Strings. If you need to create a boxed primitive from a String, this is the way to do it.

It is worth noting that, although it is not guaranteed by the spec, in practice Java compilers implement auto boxing by calling `valueOf`.

So:

```java
Boolean b = true;
```
and

```java
Boolean b = Boolean.valueOf(true);
```

Are equivalent.

As of Java 9 the boxed primitive constructors are deprecated in favour of the `valueOf` and parse methods (see below).

## parseXXX

Similar to `valueOf` the `parseXXX` methods convert a string to a primitive, only in this case the primitive is not boxed.

```java
float f = Float.parseFloat(“1.2”);
```

This does exactly what the method says, and compared to the commonly seen alternative:

```java
float f = new Float(“1.2”);
```

It avoids the construction and unboxing of a Float object.

Similar methods exist for Boolean, Double, Integer and the other primitive types.

## isEmpty

A common clumsy idiom is to check if a Collection is empty by checking its size:

```java
if ( list.size() == 0 ) {
  // do stuff
}
```

The clearer and more concise:

```java
if ( list.isEmpty() ) {
  // do stuff
}
```

May also be more computationally efficient, depending on the data structure it is being called on.

Often there is no performance difference, but for a large `ConcurrentLinkedQueue` the difference can be significant.

## Java 9 factory methods

Java 9 added static factory `of` methods to the List, Set and Map interfaces.

These allow us to construct the collections cleanly e.g.

```java
List.of(1, 2, 3);
Set.of(42);

```

The `of` methods are overloaded to up to 10 values.

The code reads slightly better than the Java 8 `Arrays.asList` version and returns a fully structurally immutable list that does not allow elements to be replaced. It may also be slightly more efficient as it avoids allocating an array.

Although `of` is overloaded to take no parameters this expressed intent less well than `emptyList` etc which may therefore still be preferred.
