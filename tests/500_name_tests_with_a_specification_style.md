## Name test cases with a specification style

Use the name of the test case to describe one (and **only** one) behaviour of the unit under test. The name should be a proposition - i.e. a statement that could be true or false.

The method name should start with *should*. 

This is superfluous once you get good at writing test names, but in a mixed team it is useful as it encourages thinking about the test in the right way.

The rest of the name should describe a behaviour and, optionally, a scenario (identified by the word When).

For example we might start to describe `java.util.Stack` with

* `shouldBeEmptyWhenCreated`
* `shouldReturnItemsInOrderTheyWereAdded`
* `shouldThrowAnErrorWhenItemsRemovedFromEmptyStack`

Contrast this with common naming patterns found in some code bases.

* `emptyStack`
* `testEmptyStack`
* `testPush`

These names alone tell us nothing about how a `Stack` should behave.

If we omit *should* we can create more concise names

* `isEmptyWhenCreated`
* `returnsItemsInOrderTheyAreAdded`
* `throwsAnErrorWhenItemsRemovedFromEmptyStack`

Although more verbose the formulaic *should* form has an advantage - it provides a clear pattern to follow. 

If a developer knows that a test name must start with should (often because they have seen this pattern within existing tests) it is hard for them to revert to a different style and write a test that is not a proposition.

The verbosity of *should* pays for itself by forcing developers to think about tests in the right fashion.

Kevlin Henney compares *shoulds* to training wheels on a bike - a device to help while we are learning.

So when should we take the training wheels off?

This depends on the makeup of the team and how often the team changes. 

If the majority of people who are likely to work on the codebase over its lifetime are used to writing tests in this style then the added verbosity is not worth it. If a sufficiently large proportion are not then it is probably best for the team to stick with the convention.
