## Prefer Reversible Decisions

### Summary

Prefer design decisions that will be easy to change. 

### Details

Many of the decisions you make while designing your code will eventually turn out to be wrong. 

If you can make your decisions reversible by containing their consequences and adding abstractions then this future change this will not matter.

For example - if you introduce a third party library and reference it throughout your code, then you have made high the cost of reversing the decision to use that library. If you constrain it to a single location and create an interface for it, the cost of reversing the decision is low.

But don't forget KISS and YAGNI - if your abstractions complicate the design then it is better to leave them out.
