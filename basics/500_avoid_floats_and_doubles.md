## Avoid floats and doubles

Floats and doubles introduce a minefield of rounding and comparison issues. While they are a sensible choice for some domains, for server side business code `BigDecimal` is usually a better choice.

