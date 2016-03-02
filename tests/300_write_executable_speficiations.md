## Write executable specifications of what each unit should do

When writing a unit test we are **not** testing, we're **specifying**. 

To test something you only need to verify that it does what it does. To specify you need to describe what it must do in a way that can be **clearly understood**.

Each specification should specify **only** the things that it is important that each unit does - it should **not** specify things that are just details of one particular implementation of that functionality. 

If we over specify our tests will make it harder to refactor our code as we will have to make significant changes to our tests. Unit tests should enable refactoring by giving confidence that the change is correct, they should not get in the way.
