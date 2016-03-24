# Introduction

## What is This? 

This book is an attempt to capture what *"good"* Java code looks like and the practices that help produce it.

This is a problematic document to write. 

There is no one right answer to what good code looks like and there are many well-respected books that serve the same purpose such as *Effective Java*, *Clean Code* and others.

So why this document?

It differentiates itself by being :

* Freely distributable
* Open for update - contributions, corrections and updates are encouraged
* Brief - much is left out in an attempt to be easily digestible 
* Narrow - it captures one opinion of *"good"* appropriate for a specific context

This last point is important. 

We assume a number of things about you and the environment you are working in.

* We assume you are writing server side Java in *small* teams.
* We assume your teams are of mixed experience (some experts, some beginners).
* We assume you are writing code in a general "business" context. 
* We assume you expect the code to still be in use in five years time. 

Some of the suggestions may be valid in other contexts, others might constitute terrible advice for those contexts.

It is also just one opinion from many valid alternatives. To be useful it needs to be an opinion that you can agree with and sign up to. If you disagree with its content you are encouraged to make your own thoughts known so the document can be improved.

Finally, not all the code we work on is perfect. Sometimes we inherit our own mistakes, sometimes we inherit other peoples. 

The point of this document is not to say that all code must look like this but to have an agreed destination that we are aiming for.

## Who is This For?

This document is intended for consumption by anyone involved with writing server side Java code. From developers writing Java for the first time through to seasoned technical leads serving multiple teams. 

Some sections will be more relevant to some audiences than others but we encourage everyone to at least skim all sections even if you do not read them in depth.

## Structure

The document is split into five sections:

* Process - Discussion on development philosophy and workflow 
* Style - Good style and design at a high level
* Specifics - More specific advice on Java language features and gotchas 
* Good tests - How to write good tests
* Bad advice - Discussion of some commonly circulated bad advice and patterns

## History

Most of the content of this book began life as internal wiki pages at [NCR Edinburgh](http://ncredinburgh.com). We started to convert the wiki into this book at the end of 2015 so that it could be easily shared with other parts of our company. 

Rather than keep this as an internal document we decided to open it up to everyone in the hope that together we could make it better. 

## A word on Trade-Offs

There are no right answers in software engineering. 

It is a balancing act in which we must trade off one concern against another and make a judgement call about which balance is better for the specific scenario we have found ourselves in.

One of the most common mistakes we've seen experienced programmers make is to blindly consider only one or two concerns (often the ones with catchy acronyms) without thought for others. 

We've very carefully set out the context in which we think the advice in this book will be useful, but the context is still very broad. Slightly different situations might benefit from very different trade offs. What worked well for you in one project might not work so well in the next.

For this reason we will very rarely use words like *always* or *never*.

When we do use them we will have thought carefully before doing so, but what we really mean is almost-always or almost-never.

Having said this if you find yourself discounting any of the recommendations in this book please stop and think first. Don't fall into the trap of thinking certain advice cannot apply to you. We often make our worst mistakes when we believe we are being elegant or clever. The full horror of our ineptitude sometimes does not become apparent for months or years.

Advice is here to save us from ourselves.

## A note on Java Versions

This document is intended to apply to Java 7 and 8, but will be largely applicable to Java 5 and 6.

Where there are differences between Java 8 and 7 we will point them out. If you are unlucky enough to be working with an earlier version of Java you will have to discover any differences to Java 7 on your own. 

## License

This work is Copyright &copy; NCR, but may be read and shared with others under the terms of the Creative Commons Attribution Share Alike licence v4.0.   

## Author

This document was written by [Henry Coles](https://twitter.com/0hjc) and numerous contributors.

{% include "./contributors.md" %}

## Cover
 
The cover was produced by Peter Berry based on a wood engraving of a Long billed curlew from the 1885 text *"Nouveau dictionnaire encyclopédique universel illustré"*
 
To our knowledge Long Billed Curlews are not especially proficient in Java.


