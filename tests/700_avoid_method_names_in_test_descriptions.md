## Avoid method names in test descriptions where possible

On a practical level this can cause extra work as the descriptions must be updated if the method names are ever refactored. 

More subtly including names can make you think in the wrong fashion - verifying method implementation rather than specifying unit behaviour.

This is not a hard rule - sometimes it will be difficult/impossible to describe a meaningful behaviour without referring to the unit's interface. 

The domain language may also overlap with the method names, so you may find yourself using the same **words** as are also used as method name.
