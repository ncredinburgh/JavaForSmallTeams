# Hungarian Notation

The idea of Hungarian notation and similar schemes is to reflect the type, scope or other attribute of a variable in its name.

For example:

* bFlag
* nSize
* m_nSize

Where `b` indicates a Boolean type, `n` an integer type and `m_` that the named variable is a field.

This is a terrible idea.

Such notation *might* be useful if you are reading code printed to paper, but all the information it provides is readily available in a modern IDE. 

Naming things is hard enough without adding additional concerns that the name must handle.

These types of notation are like comments. They add noise and must be maintained in tandem with the information they duplicate. If extra effort is not spent to maintain them they become misleading.

Uncle Bob Martin puts it nicely:

> "nowadays, HN and other forms of type encoding are simply impediments. They make it harder to change the name or type of a variable, function, member or class. They make it harder to read the code. And they create the possibility that the encoding system will mislead the reader"
