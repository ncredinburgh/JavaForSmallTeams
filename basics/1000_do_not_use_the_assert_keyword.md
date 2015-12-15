## Don't use the assert keyword

Assertions written with the assert keyword are only enabled when a jvm flag is set. This is not what you want.

For production code instead use libraries such as Guava's preconditions.

If you have the assert keyword in your test code ask yourself how it is that you never noticed that your tests couldn't fail and reconsider why you are not doing TDD, then use an assertion library such as AssertJ instead.
