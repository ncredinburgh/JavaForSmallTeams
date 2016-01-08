## Prefer readable code to comments

### Summary

Use comments only to explain what you cannot make the code itself explain.

### Details

From Clean Code by Robert C Martin.

*"Nothing can be quite so helpful as a well-placed comment. Nothing can clutter up a module more than frivolous dogmatic comments. Nothing can be quite so damaging as an old crufty comment that propagates lies and misinformation."*

Comments should be used only to explain the intent behind code that cannot be refactored to instead explain itself - i.e. to used document code smells.

*Bad*

```java
// Check to see if the employee is eligible for full benefits
if ((employee.flags & HOURLY_FLAG) &&
(employee.age > 65))
```

*Better*

```java
if (employee.isEligibleForFullBenefits())
```
