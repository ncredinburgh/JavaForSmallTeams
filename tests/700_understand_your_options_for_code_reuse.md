## Understand Your Options for Code Reuse

Reusing code is a good thing. 

When people start programming in an OO language for the first time they tend to over-use inheritance for this purpose before discovering that composition is generally a better idea.

Unfortunately, it is not easy to use composition to reuse code in JUnit tests and this can lead you to write difficult-to-maintain test class hierarchies. 

A small amount of duplication may be preferable to introducing a class hierarchy when other options do not exist, but code of certain types may instead be reused via some common patterns.

### Assertions

Code related to assertions is straightforward to reuse outside of class hierarchies. This can be done trivially, by creating classes containing static assert methods that can be statically imported (as the built in JUnit assertions now are), or more elegantly by creating custom matchers for hamcrest or FEST.

### Object Creation

For small, simple objects, the mother pattern can be used, but this can quickly become a maintenance issue if the objects become more complex over time.

A better pattern is the Builder pattern, this can have the added advantage of allowing tests to clearly highlight important and unimportant input.

### Repeated Behaviors

If you are using JUnit then repeated section of code within a test can be packaged and re-used as [custom rules](https://github.com/junit-team/junit/wiki/Rules).

