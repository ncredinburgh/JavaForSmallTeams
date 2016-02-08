## Use a consistent code layout within each project

### Summary

Agree and enforce a standard code formatting scheme within each codebase.

### Detail 

The way in which Java code is formatted and laid out is largely a matter of personal preference.

Some styles (such as omitting braces in conditional statements) can arguably make certain types of bug slightly more likely. 

Others might require more work to keep the code compliant (such aligning fields into columns), but to a first approximation no particular scheme is greatly superior to any other. 

Despite this programmers tend to have strong opinions on the matter.

Every codebase should however have a single agreed formatting style which is consistently applied and is understood by everyone working on that codebase. 

This prevents commit wars in which different team members re-format things to their personal preference. It also  makes code easier to understand as there is a cognitive cost for the reader if formatting changes radically from file to file.

Although there is value in consistency, there is also a cost. 

Unless there is already broad agreement across teams about how things should be formatted, trying to enforce one official set of rules is likely to create more ill will than benefit.

A global preferred reference should therefore be set, but teams should be free to deviate from this as they see fit as long as a consistent style is used for the code they maintain.

### Suggested formatting rules

For teams that do not have their own strong preferences, the following layout guidelines are suggested. 

They are described only briefly here, the attached eclipse settings file provides more detail. 

```java
class Example {
  int[] myArray = { 1, 2, 3, 4, 5, 6 };
  int theInt = 1;
  String someString = "Hello";
  double aDouble = 3.0;

  void foo(int a, int b, int c, int d, int e, int f) {
    if (f == 5) {
      System.out.println("fnord");
    } else {
      System.out.println(someString);
    }

    switch (a) {
    case 0:
      Other.doFoo();
      break;
    default:
      Other.doBaz();
    }
  }

  void bar(List v) {
    for (int i = 0; i < 10; i++) {
      v.add(new Integer(i));
    }
  }
}
```

##### Spaces not tabs

Tabs may appear differently depending on how an editor is configured. This will result in constant reformatting as different programmers to adapt the file to their editor settings. Spaces avoid this problem.

In some languages (e.g JavaScript before the rise of code minifiers) tabs have/had an advantage as they reduced the size of the source file compared to using multiple spaces. The increase in size of the source file is of no relevance for Java.

##### One true brace style

There are various arguments about the supposed advantages of this style, but we suggest its use mainly because it is common in the Java community.

Although simple if else statements can be more concisely written by omitting the braces we suggest that they are always included. This reduces the chance of a statement being placed outside the conditional when this was not the intent.
