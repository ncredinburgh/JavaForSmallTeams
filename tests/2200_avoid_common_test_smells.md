## Avoid common test smells

Many common smells have catchy names - learn them so you can recognise and avoid them.

* MD5Sum test       -   Test that largely duplicates the code's logic within the test
* Mystery Guest     -   Test that pulls in some external component - e.g a database either directly or indirectly via global state
* Loudmouth         -   Test clutters the console with debug messages
* General Fixture   -   Fixture (i.e setup data) that is too large with individual tests using only part of it
* Verbose Test      -   A long (in terms of LOC) test
* Eager Test        -   A test that is verifying too much
* Obscure Test      -   A test that cannot be understood at a glance
* Irrelevant Information - A test that exposes lots of irrelevant details
