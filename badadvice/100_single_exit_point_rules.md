## Bad Advice - Single Exit Point Rules

Some coding standards mandate that all methods should have a single exit point.

Doing so can be damaging, particularly when it is enforced by static analysis.

## Details

Single exit point is an idea with a long history dating back to the era of liberally applied gotos and spaghetti code.

In that context, adding constraints on what could happen within a function was helpful. Knowing that there is only one point that a large function can exit from makes it easier to understand.

Many modern functional languages continue to either enforce or encourage single exit points.

So it must be a good idea to add this constraint to Java right?

Lets look what happens when we are told we must only have one exit point:

**Single exit with statements**
```java
public class Example {
  private int value;

  public int single(int x) {
    int retVal = 0;

    if (x == 10) {
      retVal = -value;
    } else if (x > 0) {
      retVal = value + x;
    }

    return retVal;
  }

}
```

If we remove the single exit point constraint we get:

**Multiple exit**
```java
public class Example {
  private int value;

  public int multi(int x) {
    if (x == 10) {
      return -value;
    } 
    
    if (x > 0) {
      return value + x;
    }
    
    return 0;
  }
}
```

Which version is better?

There isn't much in it, but the multiple exit point version is easier to comprehend.

Trying to apply the single exit point constraint resulted in an additional local variable to hold return state. In the multi exit version we can clearly see what is returned when none of the conditions match. In the single exit version it is slightly less clear as the returned value is declared at the start of the method then overwritten.

So does this mean that single exit point methods are bad?

No.

It is possible to write alternate single exit implementations.

```java
  public int oneAssignment(int x) {
    final int retVal;

    if (x == 10) {
      retVal = -value;
    } else if (x > 0) {
      retVal = value + x;
    } else {
      retVal = 0;
    }

    return retVal;
  }
```

We've addressed the issues we identified earlier. We only assign to `retVal` once and it is clear what is assigned when none of the conditions match.

Is this superior in some way to the multi exit version?

Not really.

We can also write a single exit method using the `?` operator:

**Single exit with the ? operator**
```java
  public int expression(int x) {
    return  x ==  10 ? -value
        : x > 0  ? value + x
        : 0;
  }
```

We have switched from using a statement (if) to working with expressions (i.e. things that return a value). This allows us to get rid of the additional variable while maintaining a single exit point.

Is this version clearer than the multi-exit version? That is debatable and ultimately a matter of personal taste.

The code using `?`  is terse and some will find it harder to understand.

The multi-exit version is more verbose but its proponents would argue it is easier to comprehend.

If your personal preference is for the `?` operator version, it still does not follow that the single exit point rule is something you should try to universally apply.

The most likely result is that you will push people towards writing code like the earlier bloated version of our method. As Java is a largely statement-based language, you will also encounter logic where the multi-exit version is undeniably clearer.

Martin Fowler and Kent Beck express things nicely in "Refactoring: Improving the Design of Existing Code"

> ". . . one exit point is really not a useful rule. Clarity is the key principle: If the method is clearer with one exit point, use one exit point; otherwise don't"

There is nothing wrong with single exit functions, but only write them when it makes sense to do so.
