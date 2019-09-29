## Lecture: Collaborator Objects

* classes group common behaviours.
* objects encapsulate state; the object's state is saved in an object's instance variables; instance methods can operate on the instance variables.
* Usually, the state is a string or number. For example, a `Person` object's `name` attribute can be saved into a `@name` instance variable as a string. Here's an example:

```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end
end

joe = Person.new("Joe")
joe.name 									# => "Joe"
```

* Notice that `@name` holds a string object. That is, `"Joe"` is an object of the `String` class.
* There's nothing special about the `String` class. Instance variables can hold any object, not only strings and integers. It can hold data structures, like arrays or hashes.
* We can use any object to represent an object's state. Instance variables can be set to any object, even an object of a custom class we've created.

```ruby
class Person
  attr_accessor :name, :pet
  
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new  					# assume Bulldog class from previous assignment

bob.pet = bud
```

* In the last line we've essentially set `bob`'s `@pet` instance variable to `bud`, which is a `Bulldog` object. This means that when we call `bob.pet`, it is returning a `Bulldog` object.

* Objects that are stored as state within another object are also called "collaborator objects." We call such objects collaborators because they work in conjunction (or in collaboration) with the class they are associated with. 
* When we work with collaborator objects, they are usually custom objects (e.g. defined by the programmer and not inherited from the Ruby core library); `@pet` is an example of a custom object. Yet, collaborator objects aren't strictly custom objects. Even the string object stored in `@name` within `bob` in the code above is technically a collaborator object.
* Collaborator objects play an important role in object oriented design, since they also represent the connections between various actors in your program. When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.
* Next, let's develop our program some more and change the implementation a bit to allow a person to have many pets. How should we implement this? How about an array of pets--that is, an array of `Pet` objects.

```ruby
class Person
  attr_accessor :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets 								# => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
```

* Notice the opening and closing square brackets--that means this is an array. You can see that the first element in the array is a `Cat` object while the second element is a `Bulldog` object. Because it's an array, you cannot just call `Pet` methods on `pets`:

```ruby
bob.pets.jump		# NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array
```

* There is no `jump` method in the `Array` class, so we get an error. If we want to make each individual pet jump, we'll have to parse out the elements in the array and operate on the individual `Pet` object. Here, we'll just iterate through the array.

```ruby
bob.pets.each do |pet|
  pet.jump
end
```

###### Summary

* When working with collaborator objects in your class, you may be working with strings, integers, arrays, hashes, or even custom objects. Collaborator objects allow you to chop up and modularize the problem domain into cohesive pieces; they are at the core of OO programming and play an important role in modeling complicated problem domains.

