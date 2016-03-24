## Javadoc Judiciously

### Summary

Javadoc can help document code but often there are better ways to do so. 
Think carefully before deciding to write it.

### Details

#### Javadoc is Good

Javadoc is invaluable for external teams that must consume your code without access to the source.

All externally consumed code should have javadoc for its public methods. 

Ensure that all such javadoc concentrates on *what* a method does, not *how* it does it.

#### Javadoc is Bad

Javadoc duplicates information that ought to be clear from the code itself and carries a constant maintenance cost. 

If it is not updated in tandem with the code then it becomes misleading.

Do not Javadoc code that will be consumed and maintained only by your immediate team. Instead spend effort ensuring that the code speaks for itself.
