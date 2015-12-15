## Have a layered testing strategy

To effectively catch bugs and prevent regression we need to test at several different levels - unit tests are just **one** of these layers. These layers are classically shown as a pyramid.

* The pyramid is built on a large base of unit tests - there will be many of these.
* The next layer up are integration tests, where various components are testing interacting with each other.
* At the top of the pyramid are End to End or system tests. These exercise the entire system, often in a scenario based fashion (e.g. given a valid user, when they log in they should be shown X).
* Floating at the top of the pyramid are manual tests

All layers of the pyramid should be fully automated except the cloud at the top. Manual tests are required for things that either cannot be automated (e.g does this web page contain visual glitches) and to question assumptions that may have been made by the team implementing the test lower down the pyramid.

At the bottom of the pyramid there should be a lot of tests, each should run very quickly. When a test at the bottom of the pyramid fails it should be easy to understand what is not working.

As we go up the pyramid there are fewer tests, but each one is likely to run more slowly. More things might make each test fail, and it becomes harder to understand what caused that failure due to the increased complexity

Although the tests at the top of the pyramid are likely to exercise the system via the GUI it is important to understand that these are not the tests **for** the GUI. As much are possible the GUI should be treated like all other components, with unit tests, integration tests and a small number of end to end tests.
