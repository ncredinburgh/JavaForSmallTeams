## Optimise for readability not performance

### Summary

Don't optimise your code prematurely. 

Concentrate on making it simple and understandable instead.

### Details

Many new programmers worry about the performance of each method they write, avoid code they expect to be inefficient and write in a style that attempts to minimise object allocations, method calls, assignments or other factors they expect to have a cost. 

Although they often decrease readability and increase complexity, most micro performance optimisation provide no performance benefit at all.

Within the context in which we work performance should be one of the concerns considered last. Instead attention should be paid to making code as simple and readable as possible.

If a performance issue arises profiling should be used to identify where the problems actually lie.

This does not mean the performance should be disregarded completely, just that it is a minor concern and should always be trumped by code readability and simplicity until it can be proven that there is a real benefit. Where code can be written in a more efficient manner without **any** increase in complexity or trade off with readability then the (presumed) more efficient code should still be preferred.

