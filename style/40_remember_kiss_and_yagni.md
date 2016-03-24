## Remember KISS and YAGNI

### Summary

Keep your design as simple as possible. 

Create only the functionality you need now - not what you think you might need in the future.

### Details

The KISS (Keep It Simple, Stupid) and YAGNI (You Ain't Going To Need It) acronyms provide good advice that is worth remembering while coding.

KISS advises that we keep our code and designs as simple as possible.  

Few people would disagree with this, but unfortunately it is not always obvious what *simple* means.

Given two solutions to a problem which one is simpler?

* The one with the least lines of code?
* The one with the least number of classes?
* The one that uses fewer third party dependencies?
* The one with fewer branch statements?
* The one where the logic is most explicit?
* The one which is consistent with a solution used elsewhere?

All of the above are reasonable definitions of *simple*. None of them is the single definition always makes sense to follow.

Recognizing simple isn't easy and keeping things simple takes a lot of work. 

If we could somehow measure the complexity of our software, we would find that there is some minimum value that each piece of software must contain. 

If the software were any simpler, then it would be less functional. 

Real programs will always contain this *inherent complexity* plus a bit. This extra complexity is the *accidental complexity* we have added because we are less than perfect.  

Telling accidental complexity apart from inherent complexity is of course also hard. 

Fortunately YAGNI gives us some useful advice on how to keep things simple without having to tell accidental and inherent complexity apart.

The more a system does, the higher it's overall complexity will be. If we make a system that does less, it will be simpler - it will have less *inherent complexity* and less *accidental complexity*

Your goal is, therefore, to create the minimum amount of functionality that solves the problems you have right **now**.

* Don't implement things because you think you might need them later. Implement in the future if you need it.
* Don't try and make things "flexible" or "configurable". Make them do just what they need to do - parameterize them at the point you have a need to do so.

If you create more than the minimum amount of functionality, you will have more code to debug, understand and maintain from that point forward until someone has the confidence to delete it.

