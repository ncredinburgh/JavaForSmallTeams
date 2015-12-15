## Don't use reflection

Introducing reflection into a codebase moves errors from compile time to run time. 

While reflection is useful for implementing frameworks, there is almost always a better solution for application code.

Tricks such as using reflection to make methods visible for testing should also be avoided - resorting to them is a sign of poor test and/or code design.
