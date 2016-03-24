## Use Coverage as a Tool, not a Target

Code coverage is a useful tool for catching your mistakes. 

The tool should work for you; you do not work for the tool.

It is most useful when code coverage is run at the point at which the code and tests are being written, rather than on a CI server hours later.

Gaps in code coverage highlight areas of code that have not been tested. Some of these gaps may be expected and intentional, others may be a surprise. It is these surprise gaps that provide useful information.

This is all that code coverage does.

Code that has 100% branch coverage may or may not have been tested. Code coverage tells you that some tests have executed the code, not that they have meaningfully tested it. Don't let it lull you into a false sense of security.

Some teams set coverage targets that code must meet (75% seems to be a common figure). Although well-intentioned, this practice is often damaging.

Code coverage is easy to measure. Other properties of tests that are desirable (or highly undesirable) are not easy to measure e.g.:

* Is the test meaningful?
* Is the test easy to read and understand?
* Is the test tightly tied to a particular implementation?

This last point is particularly important.

For a test to be of value, it must enable refactoring; tests that are tied to one particular way of solving the problem often have negative value because they must be modified or rewritten whenever the code is changed. Unfortunately, it is easy to write tests in this way for a number of months or years before you realise you were doing it wrong.

By concentrating on the one property that is easy to measure, the others are de-emphasized. But, much worse than this, trying to meet a coverage target can actively push developers towards writing tests that are tied to the implementation. Bad tests are easier to write than good tests.

It is probably fair to say that there is a problem when code has only 30% unit test coverage. On the other hand, if coverage is achieved by setting a target, code with 30% coverage may be easier to work with than code with 100% coverage.

So don't set targets, instead make sure your team is committed to writing good tests. 

A good test is one which helps explains the code, catches regression and doesn't get in the way when changes are made. Writing the tests before the code can help encourage good tests and will ensure that code has high coverage.
