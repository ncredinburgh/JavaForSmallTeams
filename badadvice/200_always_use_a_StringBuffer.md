# Always Use a StringBuffer to Concatenate 

This advice is doubly wrong. 

Firstly it advocates using the synchronized `StringBuffer` rather than a `StringBuilder`.

Secondly it is an oversimplification or misunderstanding of the more nuanced and reasonable advice to not concatenate Strings in a loop.

Avoiding concatenation in a loop is reasonable. Using a `StringBuilder` is likely to be more efficient if the loop executes a reasonable number of times as it will avoid string allocations. 

The performance difference is unlikely to be significant in most cases, but the resulting code isn't noticeably less-readable - so it is a premature optimization without a cost.

Lets see what happens when we apply this advice when no loop is present:

```java
  public String buffer(String s, int i) {
    StringBuilder sb = new StringBuilder();
    sb.append("Foo");
    sb.append(s);
    sb.append(i);
    return sb.toString();
  }

  public String concat(String s, int i) {
    return "Foo" + s + i;
  }
```

The `concat` version is far clearer.

So the `concat` is cleaner of the two functions. Which is more efficient?

The eclipse compiler generates the following bytecode for `concat`:

```
    NEW java/lang/StringBuilder
    DUP
    LDC "Foo"
    INVOKESPECIAL java/lang/StringBuilder.<init> (Ljava/lang/String;)V
    ALOAD 1
    INVOKEVIRTUAL java/lang/StringBuilder.append (Ljava/lang/String;)Ljava/lang/StringBuilder;
    ILOAD 2
    INVOKEVIRTUAL java/lang/StringBuilder.append (I)Ljava/lang/StringBuilder;
    INVOKEVIRTUAL java/lang/StringBuilder.toString ()Ljava/lang/String;
    ARETURN
```

A `StringBuilder` is created by the compiler behind the scenes to handle the concatenation so our simpler cleaner code produces identical bytecode to the more verbose option.

The presence of loops in the code may prevent the compiler performing this optimization, but code without branches will be optimized every time. Although compilers may exist that do not support this optimization it is unlikely that you will ever use them.
