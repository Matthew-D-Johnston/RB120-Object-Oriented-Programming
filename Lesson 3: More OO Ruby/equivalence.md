## Lesson 3: More OO Ruby: Equivalence

###### Summary

###### `==`

* for most objects, the `==` operator compares the values of the objects, and is frequently used.
* the `==` operator is actually a method. Most built-in Ruby classes, like `Array`, `String`, `Integer`, etc. override the `==` method to specify how to compare objects of those classes.
* by default, `BasicObject#==` does not perform an equality check; instead, it returns true if two objects are the same object. This is why other classes often override the behaviour of `#==`.
* if you need to compare custom objects, you should override the `==` method.
* understanding how this method works is the most important part of this assignment.



###### `equal?`

* the `equal?` method goes one level deeper than `==` and determines whether two variables not only have the same value, but also whether they point to the same object.
* do not override `equal?`.
* the `equal?` method is not used very often.
* calling `object_id` on an object will return the object's unique numerical value. Comparing two objects' `object_id` has the same effect as comparing them with `equal?`.



###### `===`

* used implicitly in `case` statements.
* like `==`, the `===` operator is actually a method.
* you rarely need to call this method explicitly, and only need to implement it in your custom classes if you anticipate your objects will be used in `case` statements, which is probably pretty rare.



###### `eql?`

* used implicitly by `Hash`.
* very rarely used explicitly.

