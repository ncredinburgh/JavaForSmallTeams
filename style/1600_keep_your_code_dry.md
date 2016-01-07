## Keep your code DRY

Don't Repeat Yourself.

*Bad*

```java
class Foo {
   private int status;
   private boolean approved;

   foo() {
     if (status == 12 || approved) {
       doFoo();
     }
   }

   bar() {
     if (status == 12 || approved) {
       doBar();
     }
   }
}
```

*Better*

```java
class Foo {
   private final static int PRE_APPROVED = 12;

   private int status;
   private boolean approved;

   foo() {
     if (isApproved()) {
       doFoo();
     }
   }

   bar() {
     if (isApproved()) {
       doBar();
     }
   }

   private isApproved() {
     return status == PRE_APPROVED || approved;
   }
}
```

