## Lesson 3: More OO Ruby: Inhertiance and Variable Scope

**Instance Variables** behave the way we'd expect. The only thing to watch out for is to make sure the instance variable is initialized before referencing it.  

**Class Variables** have a very insidious behaviour of allowing sub-classes to override super-class  class variables. Further, the change will affect all other sub-classes of the super-class. This is extremely unintuitive behaviour, forcing some Rubyists to eschew using class variables altogether.  

**Constants** have _lexical scope_ which makes their scope resolution rules very unique compared to other variable types. If Ruby doesn't find the constant using lexical scope, it'll then look at the inheritance hierarchy.

