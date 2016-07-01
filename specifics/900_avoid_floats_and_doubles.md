## Double or BigDecimal?

### Summary

Be aware that double can be approximate -- it will round some numbers. 
If that is a problem -- for example, when handling money -- then try the BigDecimal class.

Avoid using floats -- they're no faster than doubles on a modern computer.

### When to Avoid Double

Floats and doubles come with rounding issues. If that is a problem, for example when handling money any rounding might be a legal issue, then look at `BigDecimal` instead.

The core issue is that floating point numbers are not able to represent many numbers (e.g. `0.1` or '1/3').

This leads to unexpected results that may not be caught by simple test cases

```java
    double balance = 2.00;
    double transationCost = 0.10;
    int numberTransactions = 6;

    System.out.printf("After %s transactions balance is %s"
                    , numberTransactions
                    , balance - (transationCost * numberTransactions));
    // Gives After 6 transactions balance is 1.4 :-)
```

But

```java
    double balance = 2.00;
    double transationCost = 0.10;
    int numberTransactions = 7;

    System.out.printf("After %s transactions balance is %s"
                     , numberTransactions
                     , balance - (transationCost * numberTransactions));
    // Gives After 7 transactions balance is 1.2999999999999998 :-(
```

This simplest solution in this case would be to replace the floats with integer values (i.e. track the balance in units of cents rather than dollars), but the code could also be re-written to use `BigDecimal`.

```java
    BigDecimal balance = new BigDecimal("2.00");
    BigDecimal transationCost = new BigDecimal("0.10");
    
    BigDecimal numberTransactions = BigDecimal.valueOf(7);

    System.out.printf("After %s transactions balance is %s"
                     , numberTransactions
                     , balance.subtract(transationCost.multiply(numberTransactions)));

   // Gives After 7 transactions balance is 1.30 :-)
```

Note that, although `BigDecimal` can be constructed from a float, this takes us back to where we started.


```java
    BigDecimal balance = new BigDecimal("2.00");
    BigDecimal transationCost = new BigDecimal(0.10); // <- float used to construct
    
    BigDecimal numberTransactions = BigDecimal.valueOf(7);

    System.out.printf("After %s transactions balance is %s"
                     , numberTransactions
                     , balance.subtract(transationCost.multiply(numberTransactions)));

   // Gives After 7 transactions 
   // balance is 1.2999999999999999611421941381195210851728916168212890625
```

### When to Use Double

Double has some real advantages over BigDecimal. For many use-cases you don't need to worry about rounding, so it's not a core concern. In that case, the more readable code you get with double is better.

Other advantages are:

1. Performance. In some domains, such as machine learning, arithmetic can be a bottleneck. double operations are supported at the hardware level and are considerably faster than BigDecimal.

2. Third party libraries tend to use double. There is little point having your code in BigDecimal, if you're going to pipe it through a double-based library. If anything, by hiding the floating point code, that might give a false impression that rounding errors were impossible.

3. Clear code. Compare the following:

	double x = 3;
	double y = 2*x + 1;

vs

	BigDecimal a = BigDecimal.valueOf(3);
	BigDecimal b = a.multiply(BigDecimal.valueOf(2)).add(BigDecimal.valueOf(1));

doubles are a lot more readable!

(On a vaguely related note, it's a shame Java doesn't have a limited form of overloading for the + - * / operators. it would make maths code much more readable.)

4. Robustness. In many cases, handling rounding in the background is the right choice, as opposed to BigDecimal's more cautious error-on-approximation. For example:

	BigDecimal third = BigDecimal.valueOf(1).divide(BigDecimal.valueOf(3));

This code is not just unsightly, it will throw an exception. That's not immediately obvious (note that you can handle by explicitly specifying a rounding mode). The behaviour of 1.0/3.0 -> approximately 1/3 is usually preferable.


