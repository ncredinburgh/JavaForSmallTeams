## Name test cases with a specification style

Use the name of the test case to describe one (and **only** one) behaviour of the unit under test.

The method name should start with *should*. This is superfluous once you get good at writing test names, but in a mixed team it is useful as it encourages thinking about the test in the right way.

The rest of the name should describe a behaviour and optionally a scenario (identified by the word When). e.g we might start to describe `java.util.Stack` with

* `shouldBeEmptyWhenCreated`
* `shouldReturnItemsInOrderTheyWereAdded`
* `shouldThrowAnErrorWhenItemsRemovedFromEmptyStack`
