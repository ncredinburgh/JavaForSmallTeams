## Fast Feedback

## The Build File is Truth

The build script provides less-immediate feedback than the IDE because it must be explicitly triggered.

Feedback from the build script has two major advantages, however:

* It is repeatable across all machines
* With the aid of a CI server, you can ensure it is not ignored

Because slower feedback is acceptable from the build script, a larger set of static and dynamic analysis can be run from here. This will usually include a repeat of your instant feedback (whatever analysis is run).

## Locally Runnable Tests

After the compiler and static analysis, the next fastest levels of feedback are the test suites.

At least two suites should be maintained that are runnable locally on any developer machine. 

Because they are typically run immediately after compiling or before committing/pushing code, Martin Fowler refers to these as:

* The compile suite
* The commit suite

In Maven, these map naturally to the `test` and `integration-test` phases.

The criteria for a test being placed in the compile suite should, however, be more than **just** its execution speed. 

They must be fast (milliseconds or less per test) but must also be highly deterministic and repeatable. This ensures that the suite provides clean feedback - the only reason that a test should fail after a code change is if the change has caused regression.

Although this sounds simple, in practice it requires considerable rigor to ensure that tests cannot interfere with each other or be affected by external factors. 

Tests in the commit suite may be slower and may also be slightly less repeatable. They should **aim** to be 100% repeatable but they may do things that carry the risk of occasionally causing a failure, like use network IO or write to disk. 

Although many tests in this suite may do no more than launch code within the same JVM as the tests themselves, some of the tests should also launch the built artifact (war, ear, jar) and perform at least some degree of testing against it.

Although the commit suite will likely depend on external resources such as containers, databases, queues, etc., it should still be runnable on any machine with a single command. 

Installing and starting dependent resources should be handled automatically by the build scripts and tests - your project should not come with a page of notes on how to set up a development machine. 

Commonly, the Maven Cargo plugin is used to download and configure containers for testing.
