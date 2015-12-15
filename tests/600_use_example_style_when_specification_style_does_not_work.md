## Use the example style when specification style does not work

Occasionally it is not possible to follow the specification naming style because the descriptions become too long and unwieldy. If it feels like your method names are becoming overly long ask yourself two questions

1. Am I really testing only one thing?
2. Is my unit doing too much?

If you're confident the answer is no to both then switch to a different style - example style.

In example style the name describes only the "When" part. It does not describe the expected behaviour.

e.g

* `emptyStack`
* `oneItemAdded`
* `removalFromEmptyStack`

If you use example style naming you must ensure that your tests are readable at a glance.
