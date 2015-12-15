## Agree the language you use when discussing tests

Unfortunately the language of testing is heavily overloaded, with different communities referring to different things by the same names.

The testing pyramid is a widely recognised diagram of how testing should be approached. It shows large numbers of unit tests at the bottom, with a smaller number of integration tests above them and a yet smaller number of system tests at the peak. Often some clouds of manual testing are added at the top.

![The testing pyramid](../generated/images/svg/pyramid.png)

This diagram has probably been drawn thousands of times, but although unit tests will appear at the bottom of each version the words used at the other levels will vary wildly.

Even when the same words are used the meanings attached to them might be different. Although people might nod when you discuss "unit tests", "integration tests", "system tests", "end 2 end tests", "service tests" there is no guarantee that they are thinking of the same thing.

Depending on who you speak to a "Unit test" might be anything from a word document full of instructions, or "any test written by a programmer" through to various formal (but by no means authoritative) definitions that appeared in text books.

A fairly tight definition of unit test now in common use in the Java community. To be a Unit test, a test must be

* Fast (miliseconds or less)
* Isolated (test only one unit)
* Repeatable (able to be run millions of times on any machine with the same result)
* Self verifying (either passes or fails)
* Timely (written first)

It is reccomended that you and your team use this definition with one note on the final point.

Although writing your tests first is often a very good idea, a test that meets the other criteria is still a unit test regardless of when it was written. 

Although we talk about "unit" testing, what constitutes a "unit" isn't necessarily that obvious.

A somewhat circular definition is that a Unit is the smallest thing it makes sense to test independently. Although it will often be a single class this is not necessarily the case - it may make sense to treat a collaboration of classes as a unit (particularly if most of them are non public) or occasionally even a method.

If we accept that a "Unit" is a small thing, and that we'll know it when we see it, then we can see that the criteria for being a unit test largely matches the criteria we put forward for the compile suite with the exception that the compile suite does not care about isolation.

If we choose to write a test that tests two (or more) units in tandem, it still belongs in the compile suite (as long as it meets the other criteria).

System tests are also fairly well defined, in that they are tests that exercise the overall system (i.e all your code and all the other code it interacts with in a realistic environment).

Integration tests are less easy to define, they occupy the large space of everything that doesn't fit the unit or system tests definitions.

The two diagrams show how this terminology fits into our world of test suites. 

This document will use the terminology Unit test, Integration test and System test as shown in these diagrams. For clarity it will sometimes state exactly what is being tested when discussing integration tests - e.g "test via the REST api of the war running in tomcat". Although it is tedious, this long-hand terminology is clear and it is recommended that you use it when discussing testing across teams, it is likely that you develop your own shorter language within each team.

![Properties of different test types](../generated/images/svg/test_types.png)

This maps to our suites as shown below

![Test suites](../generated/images/svg/test_types_maven.png)
