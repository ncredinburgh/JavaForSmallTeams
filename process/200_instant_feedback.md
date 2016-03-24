## Instant Feedback

A modern IDE such as Eclipse or IntelliJ will provide instant feedback as you type, using the underlying compiler and configurable static analysis tools.

You can increase the amount of instant feedback you receive by making good use of the Java type system and configuring the static analysis tools.

While feedback from the IDE is fast and convenient, it has some drawbacks.

* It may differ from machine to depending on the IDE configuration
* It is often non binary (i.e. not pass/fail)
* It can be ignored / overlooked
* The expectation of speed limits what it can achieve
 
For these reasons you should avoid purely IDE centric work flows. Code should not be considered complete by a developer until tests have been run via the build file.
