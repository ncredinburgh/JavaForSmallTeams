## Only Unit Test Code That It Makes Sense to Unit Test

In most cases, there is little value in unit testing:

* Auto generated code
* Logging
* Code whose **sole** concern is integration with another system

The canonical example of code with a pure integration concern is a DAO. 

If a compatible in-memory fake database is available then it can be meaningfully unit tested against that. If no fake is available, there is no value in writing tests that mock out the JDBC driver - the first level of testing should instead be integration testing against a real database.

These is also little value in **explicitly** specifying the behavior of very simple boiler plate code such as get/set methods. The expected behavior is clear without the presence of a test and their actual behavior ought to be verified by other tests that use the code while testing more complex logic. If code coverage indicates that these methods have not been executed by other tests perhaps you can delete them?

Code that is not unit tested should always be integration tested.
