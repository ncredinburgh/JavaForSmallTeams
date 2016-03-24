## Write Repeatable Unit Tests

Unit tests must be repeatable and deterministic - it must be possible to run them thousands of times in any order and get the same result. This means that they must have no dependency on any external factor.

In practice this means unit tests must not:

* Read or write from databases
* Perform network IO
* Write to disk
* Modify static state

If your test does any of these things then it is not a **unit** test. This is not to say that your is not valuable. 
