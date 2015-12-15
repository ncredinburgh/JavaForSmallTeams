## Follow standard TEA naming convention for test variables

Make it clear which class you are testing by always naming it `testee`.

If you need to store an expected value in a variable, call it `expected` (but don't store it in a variable just for the sake of it).

Store actual values that you will compare against an expectation `actual` (but don't store it in a variable just for the sake of it).

If you have stubbed a participant consider naming it `stubbedFoo` or `mockedFoo` (stubbed is more accurate). This rule is less hard than the others - decide on a case by case basis whether you think it makes your test more or less readable. 
