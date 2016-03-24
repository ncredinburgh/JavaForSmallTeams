## Avoid Floats and Doubles

### Summary

Avoid using floats and doubles (both the primitives and their wrappers). 

### Detail

Floats and doubles introduce a minefield of rounding and comparison issues. While they are a sensible choice for some domains where you do not care about rounding errors, integers or `BigDecimal` are usually a better choice for server-side business code.

The core issue is that floating point numbers are not able to represent many numbers (e.g. `0.1`).

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

   // Gives After 7 transactions balance is 1.2999999999999999611421941381195210851728916168212890625
```

