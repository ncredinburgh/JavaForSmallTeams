## Use Final Liberally

### Summary

Consider making final any variable or parameter that does not change. 

### Details

Making parameters and variables that are assigned once final makes a method easier to understand because it constrains the things that could possibly happen within the code.

It would be reasonable to make parameters and assign-once variables final in all methods, but this needs to be weighed against the noise created by inserting the `final` keyword everywhere.

For short methods, whether the benefit outweighs the cost is arguable, but if a method is large and unwieldy then the case for making things final is much stronger.

Each team should agree a policy for making final variables.

At a minimum, everything should be made final within large method. This may also be extended to shorter methods at the team's discretion. A blanket policy has the advantage of being easy to automate/understand. A more nuanced policy is harder to communicate.

When working with legacy code, making parameters and variables final is also a useful first step in gaining understanding of the method before re-factoring. Methods that have proved difficult to express in smaller chunks will also become easier to understand when single assignment variables are final.
