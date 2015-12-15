## Optimize for readability not performance

Many new programmers worry about the performance of each method they write, avoid code they expect to be inefficient and write in a style that attempts to minimize object allocations, method calls, assignments or other operations they expect to have a cost. 

Although they often decrease readability and increase complexity, many micro performance optimization provide no performance benefit at all.

Within the context in which we work performance should be one of the concerns considered last. Instead attention should be paid to making code as readable as possible.

If a performance issue arises profiling should be used to identify where the problems actually lie.

This does not mean the performance should be disregarded completely, just that it is a minor concern and should always be trumped by code readability and simplicity until it can be proven that there is a real benefit.
