## Keep methods small

As a guide methods should not usually be longer than 7 lines in length. Methods longer than this should be refactored into smaller methods.

Bad

```java
 protected static Map<String, String> getHttpHeaders(HttpServletRequest request) {
        Map<String, String> httpHeaders = new HashMap<String, String>();

        if (request == null || request.getHeaderNames() == null) {
            return httpHeaders;
        }

        Enumeration names = request.getHeaderNames();

        while (names.hasMoreElements()) {
            String name = (String)names.nextElement();
            String value = request.getHeader(name);
            httpHeaders.put(name.toLowerCase(), value);
        }

        return httpHeaders;
    }
```

Better

```java
    protected static Map<String, String> getHttpHeaders(HttpServletRequest request) {
        if ( isInValidHeader(request) ) {
            return Collections.emptyMap();
        }
        return extractHeaders(request);
    }

  private static Map<String, String> extractHeaders(HttpServletRequest request) {
    Map<String, String> httpHeaders = new HashMap<String, String>();
        for ( String name : Collections.list(request.getHeaderNames()) ) {
            httpHeaders.put(name.toLowerCase(), request.getHeader(name));
        }
        return httpHeaders;
  }

  private static boolean isInValidHeader(HttpServletRequest request) {
      return (request == null || request.getHeaderNames() == null);
  }
```

This is not a hard rule - just a guide of when to feel uncomfortable with a method's size. There will be methods that cannot be more cleanly expressed by breaking them into smaller methods.
