## Write DAMP code

Copy and paste coding is bad in tests as well as production code - the more code there is the harder it is to read and if a concern changes copy and paste coding will lead to shotgun surgery. 

Repetition should therefore generally be avoided in test code.

Test code **is** different from production code however. 

Test code must tell more of a story - highlighting what is important and hiding what is not. Test code should not be as DRY ( **D**on't **R**epeat **Y**ourself ) as production code. It should be DAMP ( contain **D**escriptive **A**nd **M**eaningful **P**hrases ).

If refactoring a small amount of code out a test method into a shared method hides what is happening, accept the duplication and leave it in place. If it does not affect readability then refactor mercilessly.

