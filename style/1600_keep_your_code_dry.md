## Keep your code DRY

### Summary

Don't Repeat Yourself.

### Details

If the same logic occurs more than once it should not be duplicated, it should instead be extracted to a well named class or method. 

This will be both easier to read and easier to maintain as a change will only be required in one place should the logic need to change.

*Bad*

```java
class Foo {
   private int status;
   private boolean approved;

   foo() {
     if (status == 12 || approved) {
       doFoo();
     }
   }

   bar() {
     if (status == 12 || approved) {
       doBar();
     }
   }
}
```

*Better*

```java
class Foo {
   private final static int PRE_APPROVED = 12;

   private int status;
   private boolean approved;

   foo() {
     if (isApproved()) {
       doFoo();
     }
   }

   bar() {
     if (isApproved()) {
       doBar();
     }
   }

   private isApproved() {
     return status == PRE_APPROVED || approved;
   }
}
```

Things are a little trickier when we have similar but not identical logic.

The worse thing we can do is copy and paste.

**Terrible**
```java
public void doSomething(List<Widget> widgets) {
  for (Widget widget : widgets) {
    reportExistence(widget);
    if (widget.snortles() > 0) {
      reportDeviance(widget);
      performSideEffect(widget);
    }
  }
}
  
public void doSomethingSimilar(List<Widget> widgets) {
  for (Widget widget : widgets) {
    reportExistence(widget);
    if (widget.snortles() > 0) {
      reportDeviance(widget);
      performDifferentSideEffect(widget);
    }
  }
}
```

A straightforward but very limited approach is to introduce boolean flags.

**Not great**
```java
public void doSomething(List<Widget> widgets) {
  doThings(widgets, false);
}
  
public void doSomethingSimilar(List<Widget> widgets) {
  doThings(widgets, true);
}
  

private void doThings(List<Widget> widgets, boolean doDifferentSideEffect ) {
  for (Widget widget : widgets) {
    reportExistence(widget);
    if (widget.snortles() > 0) {
      reportDeviance(widget);
      if (doDifferentSideEffect) {
        performDifferentSideEffect(widget);
      } else {
        performSideEffect(widget);
      }
    }
  }
}
```

A much more scalable approach is to use the Strategy pattern to separate the concerns.

If we introduce an interface

```java
interface WidgetAction {
   void apply(Widget widget);
}  
```

Then we can use it as follows

**Better**
```java
public void doSomething(List<Widget> widgets) {
  doThings(widgets, performSideEffect());
}


public void doSomethingSimilar(List<Widget> widgets) {
  doThings(widgets, performDifferentSideEffect());
}
  
private WidgetAction performSideEffect() {
  return new WidgetAction() {
    @Override
    public void apply(Widget widget) {
      performSideEffect(widget);
    }    
  };
}
  
private WidgetAction performDifferentSideEffect() {
  return new WidgetAction() {
    @Override
    public void apply(Widget widget) {
      performDifferentSideEffect(widget);
    }    
  };
}
    
private void doThings(List<Widget> widgets, WidgetAction action ) {
  for (Widget widget : widgets) {
    reportExistence(widget);
    if (widget.snortles() > 0) {
      reportDeviance(widget);
      action.apply(widget);
    }
  }
}
```

The Java 7 version is quite verbose due to the anonymous inner class boiler plate. 

Arguably boolean flags might be preferable for very simple cases such as this.  

If the logic in the `performSideEffect` and `performDifferentSideEffect` methods is complex enough to be pulled into separate top level classes implementing `WidgetAction` then the Strategy version becomes compelling. 

In Java 8 there is little question that the Strategy pattern is preferable even in the simplest of cases.

**Better with Java 8**
```java
public void doSomething(List<Widget> widgets) {
  doThings(widgets, widget -> performSideEffect(widget));
}

public void doSomethingSimilar(List<Widget> widgets) {
  doThings(widgets, widget -> performDifferentSideEffect(widget));
}
  
private void doThings(List<Widget> widgets, Consumer<Widget> action ) {
  for (Widget widget : widgets) {
    reportExistence(widget);
    if (widget.snortles() > 0) {
      reportDeviance(widget);
      action.accept(widget);
    }
  }
}
```

We do not need to introduce our own interface - the built in `Consumer<T>` is enough, but we might consider introducing one if the `doThings` method were exposed publicly or the logic in `performSideEffect` was complex enough to pull into a top level class. 

The loop might also be converted to a pipeline.

**As a pipline**
```java
private void doThings(List<Widget> widgets, Consumer<Widget> action ) {
  widgets
  .stream()
  .peek(widget -> reportExistence(widget))
  .filter(widget -> widget.snortles() > 0)
  .peek(widget -> reportDeviance(widget))
  .forEach(action);
}
```
