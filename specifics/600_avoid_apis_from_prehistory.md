## Avoid APIs from Pre-History

### Summary

Do not use `Vector`, `StringBuffer` and other archaic part of the JDK.

### Details

Java has been around for over 20 years. In order to maintain backwards compatibility, it has hoarded all manner of APIs that no longer make sense to use. Some of them are handily marked with @Deprecated annotation, others are not.

Unfortunately, many are still used in university courses and online examples. New Java programmers may not be aware they have been replaced - a few to watch out for include:

* `java.util.Vector` - use `ArrayList` instead
* `java.lang.StringBuffer` - use `StringBuilder` instead
* `java.util.Stack` - use a `Dequeue` (e.g. `ArrayDeqeue`)
* `java.util.Hashtable` - use a `Map` (e.g. `HashMap`)
* `java.util.Enumeration` - use an `Iterator` or an `Iterable`

Each of these replacements (except `Enumeration`) differ from the originals by not being synchronized. If you think you need a synchronized collection go away somewhere quiet and think again.
