## Methods Should Do Only One Thing

### Summary

Methods should do only one thing.

#### Details

A useful guide as to whether a function is doing only one thing is given in "Clean Code" by Robert C Martin.

"another way to know that a function is doing more than “one thing” is if you can extract another function from it with a name that is not merely a restatement of its implementation."

*Bad*

```java
  public void updateFooStatusAndRepository(Foo foo) {
     if ( foo.hasFjord() ) {
        this.repository(foo.getIdentifier(), this.collaborator.calculate(foo));
     }

     if (importantBusinessLogic()) {
       foo.setStatus(FNAGLED);
       this.collaborator.collectFnagledState(foo);
     }
  }
```

*Better*

```java
  public void registerFoo(Foo foo) {
     handleFjords(foo);
     updateFnagledState(foo);
  }

  private void handleFjords(Foo foo) {
      if ( foo.hasFjord() ) {
        this.repository(foo.getIdentifier(), this.collaborator.calculate(foo));
     }
  }

  private void updateFnagledState(Foo foo) {
    if (importantBusinessLogic()) {
       foo.setStatus(FNAGLED);
       this.collaborator.collectFnagledState(foo);
     }
  }
```

*You've gone too far*

```java
  public void registerFoo(Foo foo) {
     handleFjords(foo);
     updateFnagledState(foo);
  }

  private void handleFjords(Foo foo) {
      if ( foo.hasFjord() ) {
        this.repository(foo.getIdentifier(), this.collaborator.calculate(foo));
     }
  }

  private void updateFnagledState(Foo foo) {
    if (importantBusinessLogic()) {
       updateFooStatus(foo);
       this.collaborator.collectFnagledState(foo);
     }
  }

  private void updateFooStatus(Foo foo) {
    foo.setStatus(FNAGLED);
  }
```
