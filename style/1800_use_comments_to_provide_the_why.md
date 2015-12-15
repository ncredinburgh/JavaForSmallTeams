## Use comments to provide the why

A comment is only useful if it explains something that the code itself cannot.

This means that comments should provide the **why**, not the what or the how

*Bad*

```java
// make sure the port is greater or equal to 1024
if (port < 1024) {
  throw new InvalidPortError(port);
}
```
    
*Better*

```java
// port numbers below 1024 (the “well-known ports”)
// require root privileges, which we don’t have
if (port < 1024) {
  throw new InvalidPortError(port);
}
```

The above example would still be better expressed as method named `doesNotRequireRootPrivileges`, but the comment might add value within that method.
