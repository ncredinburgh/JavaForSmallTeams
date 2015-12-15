## Arrange methods top to bottom

The public methods of class should appear at the top of the file, the private methods at the bottom with any protected or package default methods in between.

In addition to arranging by accessibility they should also be ordered into a logical flow. Leaf methods that call no other methods in the class should be at the end of the file, while methods that call other methods in the class should be higher up. The reader should be able to follow the method calls with the minimal of scrolling.
