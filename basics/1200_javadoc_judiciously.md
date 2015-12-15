## Javadoc judiciously

### Javadoc is good

Javadoc invaluable for external teams that must consume your code without access to the source

All externally consumed code should have javadoc for it's public methods. 

Ensure that all such javadoc concentrates on *what* a method does, not *how* it does it.

### Javadoc is bad

Javadoc duplicates information that ought to be clear from the code itself and carries a constant maintenance cost if it is to be kept up to date.

Do not javadoc code that will be consumed and maintained only by your immediate team, instead spend effort ensuring that the code speaks for itself.
