## Choose carefully between state and interaction testing

There are two sorts of code and they require two different sorts of test.

**Worker code** does stuff. We can test worker code with **state based testing** - we give it input and assert that the output is what we expect.

**Manager code** does stuff by co-coordinating others. 

Manager code is harder to test than worker code because we need to make a choice - do we try to infer it's behaviour from it's outputs using state based testing, or do we use a mocking framework for **interaction based testing**?

Sometimes there is no choice - it is not possible to meaningfully test that a cache behaves as we wish from its outputs alone. Other times we must weigh the pros and cons.

A state based test for a manager is likely to be less easy to read and understand as it must rely on the behaviours of the objects the SUT interacts with. The test will also be coupled to these behaviours and may require changes if those behaviours change - you have effectively increased the size of the "unit" you are testing.

Interaction based testing requires us to peek beyond the unit's external interface and into its implementation. This carries the risk that we might over-specify and create an implementation specific test.

On balance it is preferable to lean towards state based testing and where possible enable it in the design of your code.

