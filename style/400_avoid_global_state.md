## Avoid global state

### Summary

Avoid introducing state global state into your program - particularly state that is accessed in hidden ways.

### Details

Adding global state to is like pouring acid over your code.

At first you might not notice the effects, but over time it will corrode and the end result will not be pretty.

Global state can take may forms including :-

* Mutable static variables
* ThreadLocals
* Singletons 

While there are a narrow set of circumstances where each of the above are useful, you will seldom encounter them in application code.


