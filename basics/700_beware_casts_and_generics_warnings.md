## Beware casts and generics warnings

The vast majority of code should not require an explicit cast. Casts are dangerous as they subvert the type system that keeps you safe. They are often warning signs that something is wrong with your design or code.

If you find yourself writing one stop and ask yourself why you are writing it. What would need to be changed in your code so you did not need to write that cast? Why can't you make that change?
