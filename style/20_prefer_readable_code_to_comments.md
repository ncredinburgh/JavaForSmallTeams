## Prefer Readable Code to Comments

### Summary

Use comments only to explain what you cannot make the code itself explain. 

If you are about to write a comment, first think if there is a way you could change the code so that it would be understandable without comments.

### Details

From Clean Code by Robert C Martin.

*"Nothing can be quite so helpful as a well-placed comment. Nothing can clutter up a module more than frivolous dogmatic comments. Nothing can be quite so damaging as an old crufty comment that propagates lies and misinformation."*

Comments should be used only to explain the intent behind code that cannot be refactored to explain itself. 

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

A comment is only useful if it explains something that the code itself cannot.

This means that any comments you do write should provide the **why**, not the what or the how

*Bad*

```java
// make sure the port is greater or equal to 1024
if (port < 1024) {
  throw new InvalidPortError(port);
}
```
    
*Better*

```java
// port numbers below 1024 (the privileged or “well-known ports”)
// require root access, which we don’t have
if (port < 1024) {
  throw new InvalidPortError(port);
}
```

*Better still*

```java
if (requiresRootPrivileges(port) {
  throw new InvalidPortError(port);
}

private boolean requiresRootPrivileges(int port) {
  // port numbers below 1024 (the privileged or "well-known ports") 
  // require root access on unix systems
  return port < 1024; 
}
```

Here, the functional intent has been captured in the method name, the comment has been used solely to provide some context as to why the logic makes sense.

The magic number might also be replaced with a constant. 

```java
final static const HIGHEST_PRIVILEDGED_PORT = 1023; 

private boolean requiresRootPrivileges(int port) {
  // The privileged or "well-known ports" require root access on unix systems
  return port <= HIGHEST_PRIVILEDGED_PORT; 
}
```

The comment arguably still adds value however - if nothing else it gives a reader unfamiliar with the topic two key phrases to search for on the web. 
