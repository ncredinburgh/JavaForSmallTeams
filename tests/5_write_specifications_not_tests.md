## Write specifications not tests

Before you sit down to write a test it's important to understand *why* you are doing it. 

What is it that you want to achieve?

There is an unfortunate tendency for developers to look at tests as a thing you have to do because it's "best practice". Some extra work to be performed after the real work is done. A chore.

The reason for writing them has become lost.

### Why write tests?

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
* Instead of documenting what the code does, the tests are harder to understand than the code itself.
* Instead of aiding development they increase the work that must be done

This first problem causes the most pain. 

If you have a test that is tied to the code's implementation, to change the way the code is implemented you have to spend effort changing the test.

If the test must change whenever the implementation changes then we cannot trust that the test will stop regression. How do we know we did not introduce a bug into the test when we changed it?

### Executable specifications

So how do we make sure we do not write negative value tests? How do we make sure we write tests that provide the benefits in our list?

The first thing to do is let go of the idea that we are testing.

We are not testing, we're *specifying*.

To test something you only need to verify that it "does what it does". To specify you need to describe the important things that it must do in a way that can be clearly understood.

A good specification describes *only* the important things. 

It describes what something *must* do without making assumptions about how it will do it. It allows for multiple implementations. If a specification is tied to one implementation then it is *over-specified* and will have to change when the implementation does.

So this is what we must aim for - an executable specification of our code.

Unfortunately it is very hard to do.

### Specification first

One simple technique that can help is to write the specification before the code. i.e. TDD.

A rigorous TDD cycle proceeds in very small steps.

First write a test and run it to ensure that it fails.

Next write just enough code to make that test pass (and no more).

Take a moment to see if there is a sensible refactoring that would improve the code, then write the next test and continue the cycle.

This has several advantages

* It guarantees that all the code *can* be tested
* As there is no implementation when the test is written it is harder to write a test that is tied to one
* It guarantees that all behaviour is covered by tests
* It discourages writing superfluous code

There are two important aspects to TDD

1. Writing the specification first
2. Moving in very small steps

Both of these practices are a good idea individually, even if they are not combined.

If we wrote our specification first, but moved in larger steps (possibly because we believed we knew what our implementation should look like) we would realise our first advantage - a guarantee that the code we wrote could be tested. We might not achieve the other benefits however.

If we were to write our code without first writing a test we would have more success if we were to execute it regularly - observing the result of each small code change to see if was what we expected. 

TDD has many advantages but it is not magic.

Even if it is applied rigorously it is entirely possible to write terrible code and specifications. TDD doesn't mean you can stop thinking. 

Despite this, if you have a good understanding of the technologies and domain in which you are working, TDD is usually the best approach if you wish to optimise for quality.

If you do not understand your domain or technology well you may find writing a specification first hard. 

The classic solution to this problem is to first gain understanding by producing a throw away spike.

### Spikes

A spike is just some quick and dirty code to explore how you might tackle the problem. At the end of the spike you will know if that approach works well or if it is worth looking for alternative approaches.

By producing a spike you gain more understanding of both the domain and the technology you are working with. Even if the conclusion at the end of the spike is that it was a poor approach, the spike was still useful as it increased your understanding.

Once you have learnt what you can from the spike it should be thrown away and the final code test driven using the knowledge you have gained.

### Spike and stabilise

Traditionally spikes are thrown away as they are inherently of low quality. Discarding the spike is done to optimise code quality at the expense of a (probably) slower delivery.

Sometimes this is not the tradeoff you want.

An alternative is to try to stabilise the spike so that it is fit for use. If you do this you will usually end up with something of lower quality than if you had started again.

You will also end up spending more effort on this piece of code over the lifetime of the project than if you had thrown the spike away. 

What you gain for this loss in quality and increase in effort is a faster *first* delivery. Sometimes this is a tradeoff worth making, sometimes it is not.

