## Choose unit size carefully

As a starting point assume that a unit will be a class, however this is not a hard rule.

A unit is really a ''single self contained logical concern'' - it may make sense to have several classes collaborate in order to capture that concern - as long as that collaboration provides a single well defined entry point. 

Making units too small may be a form of over specifying.

Making units too large may result in tests that are difficult to understand and expensive to maintain.

As a rule of thumb, if you might reasonably have made one or more classes inner classes of a different class, perhaps they should be treated as a single unit.
