## Name Test Cases With a Specification Style

Use the name of each test case to describe one (and **only** one) behavior of the unit under test. The name should be a proposition - i.e. a statement that could be true or false.

The method name should start with *should*. 

This is superfluous once you get good at writing test names, but in a mixed team it is useful as it encourages thinking about the test in the right way.

The rest of the name should describe a behavior and, optionally, a scenario (identified by the word When).

For example, we might start to describe `java.util.Stack` with:

* `shouldBeEmptyWhenCreated`
* `shouldReturnItemsInOrderTheyWereAdded`
* `shouldThrowAnErrorWhenItemsRemovedFromEmptyStack`

Contrast this with common naming patterns found in some code bases:

* `emptyStack`
* `testEmptyStack`
* `testPush`

These names alone tell us nothing about how a `Stack` should behave.

If we omit *should* we can create more concise names

* `isEmptyWhenCreated`
* `returnsItemsInOrderTheyAreAdded`
* `throwsAnErrorWhenItemsRemovedFromEmptyStack`

Although more verbose the formulaic *should* form has an advantage - it provides a clear pattern to follow. 

If a developer knows that a test name must start with *should* (often because they have seen this pattern within existing tests) it is hard for them to revert to a different style and write a test that is not a proposition.

The verbosity of *should* pays for itself by forcing developers to think about tests in the right fashion.

Kevlin Henney compares *shoulds* to training wheels on a bike - a device to help while we are learning.

So when should we take the training wheels off?

This depends on the makeup of the team and how often the team changes. 

If the majority of people who are likely to work on the codebase over its lifetime are accustomed to writing tests in this style then the added verbosity is not worth it. If a sufficiently large proportion are not then it is probably best for the team to stick with the convention.

### Use the Example Style When Specification Style Does Not Work

Occasionally, it is not possible to follow the specification naming style because the descriptions become too long and unwieldy. If it feels like your method names are becoming overly long ask yourself two questions:

1. Am I really testing only one thing?
2. Is my unit doing too much?

If you're confident the answer is "no" to both then switch to a different style - example style.

In example style the name describes only the "When" part. It does not describe the expected behavior, e.g.:

* `emptyStack`
* `oneItemAdded`
* `removalFromEmptyStack`

To understand tests named with the example style, you must read the code within the tests. For this reason, this specification style should be preferred when possible.

### Avoid Method Names in Test Descriptions Where Possible

Where possible, avoid including method names in test names.

On a practical level this avoids the extra overhead of updating test names if method names are ever refactored. 

More subtly, including names can make you think in the wrong fashion - verifying method implementation rather than specifying unit behavior.

This is not a hard rule - sometimes it will be difficult or impossible to describe a meaningful behavior without referring to the unit's interface. 

The domain language may also overlap with the method names, so you may find yourself using the same **words** as are also used as a method name.
