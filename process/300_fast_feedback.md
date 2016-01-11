## Fast feedback

## The build file is truth

The build script provides less immediate feedback than the IDE as it must be explicitly triggered.

Feedback from the build script has two major advantages however 

* It is repeatable across all machines
* With the aid of a CI server we can ensure it is not ignored

As slower feedback is acceptable from the build script a larger set of static analysis tools can be run from here - usually including a repeat of whatever analysis is run as instant feedback.

After the compiler itself, the next fastest level of feedback are the test suites.

At least two suites should be maintained that are runnable locally on any developer machine. Martin Fowler refers to these as :-

* The compile suite
* The commit suite

As they are typically run straight after compiling or directly before committing/pushing code.

In maven these map naturally to the test and integration test phases.

The criteria for a test being placed in the compile suite should however be more than just its execution speed. 

They must be fast (milliseconds or less per test) but must also be highly deterministic and repeatable. This ensures that the suite provides clean feedback - the only reason that a test should fail after a code change is if the change has caused regression.

Although this sounds simple, in practice it requires considerable rigour to ensure that tests cannot interfere with each other or be affected by external factors. 

Tests in the commit suite may be slower and may also be slightly less repeatable. They should **aim** to be 100% repeatable, but they may do things like use network IO or write to disk that carry the risk of occasionally causing a failure. Although many tests in this suite may do no more than launch code within the same JVM as the tests themselves, some of the tests should also launch the built artefact (war, ear, jar) and perform at least some degree of testing against it.

Although the commit suite will likely depend on external resources such as containers, databases, queues etc it should still be runnable on any machine with a single command. 

Installing and starting dependent resources should be handled automatically by the build scripts and tests - your project should not come with a page of notes on how to setup a development machine. Commonly the maven cargo plugin is used to download and configure containers for testing.
