## Test each thing only once

Once you've tested a concern don't let it leak into other tests - if you do those tests are no longer testing only one thing.

This is a particularly easy mistake to make with interaction based testing. If it is vitally important that the method `anImportantSideEffect` is called, it is easy to find yourself verifying that method in each test case. 

If the contract ever changes so that this side effect is not longer important, all tests will need to be updated. This concern should instead by covered by a single case `shouldPerformImportantSideEffect`.
