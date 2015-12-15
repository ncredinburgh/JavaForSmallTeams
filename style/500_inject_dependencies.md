## Inject dependencies via the constructor

Constructor dependency injection clearly communicates an objects dependencies at a glance and reduces the number of possible states an object may be in compared to setter based injection.

Bad

```java
   public class Foo() {
      private Bar bar;

      public void doStuff() {
        if (bar != null) {
          bar.doBarThings();
        }
      }

      public void setBar(Bar bar) {
        this.bar = bar;
      }
   }
```

Better

```java
   public class Foo() {
      private final Bar bar;

      public Foo(Bar bar) {
        this.bar = bar;
      }

      public void doStuff() {
        bar.doBarThings();
      }
   }
```

Dependencies should not be injected via other methods such as setters or annotated fields.

Once injected they should be stored in **final** fields.

It is also important that dependencies are actually injected. Hidden dependencies pulled in from Singletons, ThreadLocals etc are one of the main causes of unmaintainable Java code. 
