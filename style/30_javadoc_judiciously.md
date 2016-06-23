## Javadoc Judiciously

### Summary

Javadoc can help document code but often there are better ways to do so. 
Think carefully before deciding to write it.

When you're documenting an object/method/variable, ask: What would a new developer encountering this class or method need to use it? Will that be clear to a stranger from the names and structure?

Good documentation is invaluable. It enables new people to join the team, code to be reused, and it takes some of the pain out of code maintenance. But pointless documentation is actually harmful. It's a balancing act.

### Details

#### Javadoc is Good

Javadoc is invaluable for external teams that must consume your code without access to the source.

All externally consumed code should have javadoc for its public methods. 

Javadoc has IDE support, which allows for easier in-flow reference than checking the source code.

Readable method and variable names alone are not enough to make code self-documenting. 

 - Document assumptions/requirements the code has for its inputs and the system state. 
 - Exceptions -- what and why.
 - When null is allowed as a parameter or may be returned, and what that means (though avoiding null is often better).
 - In the class notes, if the object lifecycle, i.e. how this object is wired up and disposed.
 - Simple examples to aid people learning the code.

Ensure that all such javadoc concentrates on *what* a method does, not *how* it does it. 

#### Javadoc is Bad

The clearer you can make the code itself, the less documentation is needed. 

Well chosen method and parameter names are preferable to Javadoc for ambiguous names, and there is no point in Javadoc that merely repeats information the names already convey.

Javadoc duplicates information that ought to be clear from the code itself and carries a constant maintenance cost. 

If it is not updated in tandem with the code then it becomes misleading.

