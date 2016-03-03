## Write specifications not tests

Before you sit down to write a test it's important to understand *why* you are doing it. 

What is it that you want to achieve?

Tests have an unfortunate tendency to be seen as a thing you have to do. Some extra work to be performed after the real work is done. A chore.

The reason for writing them becomes lost.

### How do tests help?

The reason to write tests is to make our lives easier.

If we are not writing tests that do this we should stop writing them.

A good test should do all of the following :-

* Enable refactoring by preventing regression when the implementation changes
* Catch bugs during initial coding
* Document how the code behaves
* Inform the design of the code

When tests are viewed as a chore to be completed after the code is written only this first point is considered. 

Often it is not achieved.

Tests written with this mindset can have a negative value. 

* Instead of enabling refactoring they can increase its cost.
* Instead of catching bugs in the code as we write it, the code reveals bugs in the tests.
* Instead of documenting what the code does, they are harder to understand than the code itself.

This first problem causes the most pain. 

If you have a test that is tied to the code's implementation, to change the way the code implements its functionality you have to spend effort changing the test.

If the test must change whenever the implementation changes then the test will not help stop regression.

### Executable specifications

So how do we make sure we do not write negative value tests? 

How do we make sure we write tests that provide the benefits in our list?

The first thing to do is let go of the idea that we are testing.

We are not testing, we're *specifying*.

To test something you only need to verify that it does what it does. To specify you need to describe what it must do in a way that can be clearly understood.

A good specification also describes only the important things. 

It describes what something *must* do describing the way in which it must do it. It allows for multiple implementations. If a specification is tied to one implementation then it is *over-specified*.

So this is what we must aim for - an executable specification of our code.

Unfortunately it is very hard to do.

### Specification first

One simple technique that can help is to write the specification before the code. i.e. TDD.

A rigorous TDD cycle proceeds in very small steps.

First write a test and run it to ensure that it fails.

Next write just enough code to make that test pass (and no more).

Take a moment to see if there is a sensible refactoring that would improve the code, then write the next test and continue the cycle.

This has several advantages

* As there is no implementation when the test is written it is harder to write a test that is tied to one
* It guarantees that all the code *can* be tested
* It guarantees that all behaviour is covered by tests
* It discourages writing superfluous code

TDD has many advantages but it is not magic.

It is entirely possible to write terrible code and specifications while rigorously applying TDD. 

Although it does not guarantee good tests, if you have a good understanding of the technologies and domain in which you are working, TDD is usually the best approach.

If you do not understand your domain or technology well you may find writing a specification first hard. 

The classic solution to this problem is to first gain understanding by producing a throw away spike.

### Spikes

A spike is just some quick and dirty code to explore how you might tackle the problem. At the end of the spike you will know if that approach works well or if it is worth looking for alternative approaches.

By producing a spike you gain more understanding of both the domain and the technology you are working with. Even if the conclusion at the end of the spike is that it was a poor approach, the spike was still useful as it increased your understanding.

Once you have learnt what you can from the spike it should be thrown away and the final code test driven using the knowledge you have gained.

### Spike and stabilise

Traditionally spikes are thrown away as they are inherently of low quality. Discarding the spike is done to optimise code quality at the expense of a (probably but not necessarily) slower delivery.

Sometimes this is not the tradeoff you want.

An alternative is to try to stabilise the spike so that it is fit for use. If you do this you will usually end up with something of lower quality than if you had started again.

You will also end up spending more effort on this piece of code over the lifetime of the project than if you had thrown the spike away. 

What you gain for this loss in quality and increase in effort is a faster *first* delivery. Sometimes this is a tradeoff worth making, sometimes it is not.

