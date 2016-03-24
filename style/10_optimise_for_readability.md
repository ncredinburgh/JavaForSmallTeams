## Optimize for Readability not Performance

### Summary

Don't optimize your code prematurely. 

Concentrate on making it simple and understandable instead.

### Details

Many new programmers worry about the performance of each method they write, avoid code they expect to be inefficient and write in a style that attempts to minimize object allocations, method calls, assignments or other factors they expect to have a cost. 

Although it often decreases readability and increases complexity, most micro-performance optimization provides no performance benefit at all.

Within the context in which we work, performance should be one of the concerns considered last. Instead, attention should be paid to making code as simple and readable as possible.

If a performance issue arises, profiling should be used to identify where the problems actually lie.

This does not mean the performance should be disregarded completely, but it should always be trumped by code readability and simplicity until it can be proven that there is a real benefit to optimization. Where code can be written in a more efficient manner without **any** increase in complexity or trade-off with readability then the (presumed) more efficient code should be preferred.

