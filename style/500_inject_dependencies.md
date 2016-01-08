## Inject dependencies via the constructor

### Summary

Inject dependencies into a class via it's constructor. Do not use other methods such as setters or annotations on fields.

### Details

Constructor dependency injection clearly communicates an object's dependencies at a glance and reduces the number of possible states an object may be in compared to setter based injection.

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

Once injected they should be stored in **final** fields - this makes the life cycle of the fields unambiguous.

While annotations on fields seem convenient they tie constructions of your class to the frameworks that understand them and prevent the fields from being made final. Dependency injection frameworks can be used without introducing these issues.

If you are working with a dependency injection framework such as Spring either move construction of your objects into configuration classes or restrict the use on annotations to the constructors. Both methods allow your classes can be constructed normally.

It is also important that dependencies are actually injected. Hidden dependencies pulled in from Singletons, ThreadLocals etc are one of the main causes of unmaintainable Java code. 
