## Single Exit Point Rules

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

  public int complex(int x) {
    int retVal = 0;
    if (x > 0) {
      retVal = value + x;
    } else if (x == 10) {
      retVal = retVal - value;
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

  public int simpler(int x) {
    if (x <= 0) {
      return 0;
    }
    if (x == 10) {
      return -value;
    }
    return value + x;
  }

}
```

The multiple exit point version is clearly simpler and easier to comprehend.

Trying to apply the single exit point constraint resulted in additional local variables to hold return state. 

So does this mean that single exit point methods are bad?

No.

It is possible to write a better single exit version using the `?` operator:

**Single exit with the ? operator**
```java
public class Example {
  private int value;

  public int complex(int x) {
     return x <= 0 ? 0
          : x == 10 ? -value
          : value + 10;
  }
}
```

We have switched from using a statement (if) to working with expressions (i.e. things that return a value). This allows us to avoid the additional complication and bloat while maintaining a single exit point.

Is this version clearer than the multi-exit version? That is debatable and ultimately a matter of personal taste.

The code using `?`  is terse and some will find it harder to understand.

The multi-exit version is more verbose but its proponents would argue it is easier to comprehend.

If your personal preference is for the `?` operator version, it still does not follow that the single exit point rule is something you should try to universally apply.

The most likely result is that you will push people towards writing code like the earlier bloated version of our method. As Java is a largely statement-based language, you will also encounter logic where the multi-exit version is undeniably clearer.

Martin Fowler and Kent Beck express things nicely in "Refactoring: Improving the Design of Existing Code"

> ". . . one exit point is really not a useful rule. Clarity is the key principle: If the method is clearer with one exit point, use one exit point; otherwise don't"
