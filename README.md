# Introduction

## What is this? 

This document is an attempt to capture what *"good"* Java code looks like and the practices that help produce it.

This is a problematic document to write. There is no one right answer to what good code looks like, and there are many existing well respected books that might seem to serve the same purpose with more authority such as Effective Java, Clean Code and others.

So why this document?

It differentiates itself by being :-

* Freely distributable
* Open for update - this is a living document to which contributions, corrections and updates are encouraged
* Brief - much is left out in an attempt to be easily digestible 
* Narrow - this document tries to capture one opinion of *"good"* appropriate for a specific context

This last point is important. 

This document assumes you are writing server side Java in small teams of mixed experience for code in a general "business" context. 

Some of the suggestions may be valid in other contexts, others might constitute terrible advice for those contexts.

It is also just one opinion from many valid alternatives. To be useful it needs to be an opinion that you can agree with and sign up to. If you disagree with its content you are encouraged to make your own opinion know so the document can be improved.

Finally not all the code we work on is perfect. Sometimes we inherit our own mistakes, sometimes we inherit other peoples. 

The point of this document is not to say that all code must look like this but to have an agreed destination that we are aiming for.

## Who is this for?

This document is intended for consumption by anyone involved with writing server side Java code, from developers writing Java for the first time through to seasoned technical leads serving multiple teams. 

Some sections will be more relevant to some audiences than others but we encourage everyone to at least skim all sections even if you do not read them in depth.

## Structure

The document is split into four sections

* Process - Discussion on development philosophy and workflows 
* Style - Good style and design at a high level
* Basic good practice and gotchas - Specific advice on Java language features and know gotchas 
* Good tests - How to write good tests

Due to its content the first section is a little more verbose than the others, which attempt to be a little snappier.

## A note on Java versions

This document is intended to apply to Java 7 and 8, but will be largely applicable to Java 5 and 6 which don't really differ all that greatly from 7.

## Licence

This work is Copyright &copy; NCR, but may be read and shared with others under the terms of the Creative Commons Attribution Share Alike licence v4.0.   

## Author

This document was written by Henry Coles and numerous contributors.

{% include "./contributors.md" %}

## Cover
 
The cover was produced by Peter Berry based on a wood engraving of a Long billed curlew from the 1885 text *"Nouveau dictionnaire encyclopédique universel illustré"*
 
To our knowledge Long Billed Curlews are not especially proficient in Java.


