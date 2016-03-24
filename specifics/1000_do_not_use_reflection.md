## Don't use Reflection

### Summary

Do not use reflection in your code (i.e. anything from the `java.lang.reflect` package).

### Details

Reflection is a powerful tool; it allows Java to do things that would otherwise be either impossible or require large amounts of boilerplate code. 

But, while it is sometimes useful when creating a framework or library it is unlikely to be a good way to solve the types of problem we encounter in normal server-side application code.

So why would we want to avoid using a powerful tool that Java provides?

Reflection has three main drawbacks:

#### Loss of Compile Time Safety

Reflection moves errors from compile time to runtime - this is a Bad Thing &trade;

The compiler is our first form of defense against defects and the type system is one of the most effective tools we have to document our code. We should not throw these things away lightly.

#### Loss of Refactor Safety

Refactoring and code analysis tools are blind to reflection.

Although they may make some attempt to take it into account, the additional possibilities they create for how a program might behave mean the tools can no longer provide rigorous guarantees that they have understood the program. Otherwise, safe refactorings may change program behavior in the presence of reflection and analysis tools may report incorrect results.

#### Harder Code Comprehension

In the same way that Reflection makes it harder for automated tools to understand code, it also makes it harder for humans to understand code.

Reflection introduces surprises.

*This method is never called, I can safely delete it.* Oh. Reflection.

*I can safely change the behavior of this private method as I know where it is called from.* Oh. Reflection.

