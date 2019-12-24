##### Courses > RB129 Assessment: Object Oriented Programming > Instructions for Assessment RB129

---

## Part 1: Study Guide for Test

### Specific Topics of Interest

* Classes and objects
* Use `attr_*` to create setter and getter methods
* How to call setters and getters
* Instance methods vs. class methods
* Referencing and setting instance variables vs. using getters and setters
* Class inheritance, encapsulation, and polymorphism
* Modules
* Method lookup path
* self
  * Calling methods with self
  * More about self
* Reading OO code
* Fake operators and equality
* Truthiness
* Working with collaborator objects

---

#### Classes and objects  

###### Classes & Objects

* "In Ruby, everything is an object!"
* Creating objects allows programmers to think on a new level of abstraction. Objects are represented as real-world nouns and can be given methods that describe the behaviour the programmer is trying to represent.
* Objects are created from classes. Think of classes as molds and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class. 
* Ruby defines the attributes and behaviours of its objects in **classes**.
* You can think of classes as basic outlines of what an object should be made of and what it should be able to do.
* The entire workflow of creating a new object or instance from a class is called **instantiation**.
* When defining a class, we typically focus on two things: _states_ and _behaviours_. States track attributes for individual objects. Behaviours are what objects are capable of doing. Instance variables keep track of state, and instance methods expose behaviour for objects.
* Objects do not share state between other objects, but do share behaviours. Put another way, the values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviours) defined in the class.
* Classes also have behaviours not for objects (class methods).



---

#### Use `attr_*` to create getter and setter methods  

* Because _getter_ and _setter_ methods are so commonplace, Ruby has a built-in way to automatically create them for us, using the **attr_accessor** method. 
* The `attr_accessor` method takes a symbol as an argument, which it uses to create the method name for the `getter` and `setter` methods. 
* If we only want the getter method without the setter method then we would want to use the `attr_reader` method. It works the same way but only allows you to retrieve the instance variable. And if you only want the setter method, you can use the `attr_writer` method.
* All of the `attr_*` methods take a `Symbol` as parameters.



---

#### Instance Methods vs. Class Methods

* The `initialize` method gets called every time you create a new object. That's odd, don't we call the `new` method when we create an object? Yes, calling the `new` class method eventually leads us to the `initialize` instance method. We refer to the `initialize` method as a _constructor_, because it gets triggered whenever we create a new object. You can pass arguments into the `initialize` method through the `new` method.
* All objects of the same class have the same behaviours, though they contain different states.
* Class methods are methods we can call directly on the class itself, without having to instantiate any objects.
* When defining a class method, we prepend the method name with the reserved word `self.`.
* Class methods are where we put functionality that does not pertain to individual objects. Objects contain state, and if we have a method that does not need to deal with states, then we can just use a class method.



---

#### Referencing and setting instance variables vs. using getters and setters  

With getter and setter methods, we have a way to expose and change an object's state. We can also use these methods from within the class as well. In the previous section, the `speak` method referenced the `@name` instance variable, like below:

```ruby
def speak
  "#{@name} says arf!"
end
```

Instead of referencing the instance variable directly, we want to use the `name` getter method that we created earlier, and that is given to us now by `attr_accessor`. We'll change the `speak` method to this:

```ruby
def speak
  "#{name} says arf!"
end
```

Can you spot the change? By removing the `@` symbol, we're now calling the instance method, rather than the instance variable.  

Why do this? Why not just reference the `@name` instance variable, like we did before? Technically, you could just reference the instance variable, but it's generally a good idea to call the _getter_ method instead.  

However, we have to beware that when calling getter or setter methods, we use clear syntax so that Ruby does not think we are calling or setting _local variables_. To disambiguate from creating a local variable, we sometimes need to prefix our getter- and setter-method calls with `self` to let Ruby know that we're calling a method.





---

#### Class inheritance, encapsulation, and polymorphism  

###### Encapsulation

**Encapsulation** is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, **accomplishes this task by creating objects, and exposing interfaces (i.e., methods) to interact with those objects.**  

Encapsulation hides the implementation details of a class from other objects.

###### Polymorphism  

**Polymorphism** is the ability for data to be represented as many different types. "Poly" stands for "many" and "morph" stands for "forms". OOP gives us flexibility in using pre-written code for new purposes.  

Another way to apply polymorphic structure to Ruby programs is to use a `Module`. Modules are similar to classes in that they contain shared behaviour. However, you cannot create an object with a module. A module must be mixed in with a class using the `include` method invocation. This is called a **mixin**. After mixing in a module, the behaviours declared in that module are available to the class and its objects.  

Polymorphism is the process of using an operator or function in different ways for different data input.  

###### Inheritance  

* The concept of **inheritance** is used in Ruby where a class inherits the behaviours of another class, referred to as the **superclass**. This gives Ruby programmers the power to define basic classes with large reusability and smaller **subclasses** for more fine-grained, detailed behaviours.  
* Inheritance is when a class inherits behaviour from another class. The class that is inheriting behaviour is called the subclass and the class it inherits from is called the superclass.
* Ruby checks the object's class first for the method before it looks in the superclass.
* Inheritance can be a great way to remove duplication in your code base. There is an acronym that you'll see often in the Ruby community, "DRY". This stands for "Don't Repeat Yourself". It means that if you find yourself writing the same logic over and over again in your programs, there are ways to extract that logic to one place for reuse.
* Sub-classing from parent class. Can only sub-class from 1 parent; used to model hierarhcial relationships.
* 

---

#### Modules  

* A way to apply polymorphic structure to Ruby programs.
* Modules are similar to classes in that they contain shared behaviour. However, you cannot create an object with a module. A module must be mixed in with a class using the `include` method invocation. This is called a **mixin**. After mixing in a module, the behaviours declared in that module are available to the class and its objects.
* A **module** is a collection of behaviours that is usable in other classes via **mixins**.
* Using modules to group common behaviours allows us to build a more powerful, flexible and DRY design.
* Can mix in as many modules as needed.
* Modules are Ruby's way of implementing multiple inheritance.

##### Inheritance vs. Modules

* Now that you know the two primary ways that Ruby implements inheritance, class inheritance and mixing in modules, you may wonder when to use one vs the other. Here are a couple of things to remember when evaluating those two choices.  

  * You can only subclass from one class. But you can mix in as many modules as you'd like.
  * If it's an "is-a" relationship, choose class inheritance. If it's a "has-a" relationship, choose modules. Example: a dog "is an" animal; a dog "has an" abillity to swim.
  * You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

  ##### Modules and Namespacing  

  * In this context, namespacing means organizing similar classes under a module. In other words, we'll use modules to group related classes.

  * One advantage of namespacing is that it makes it easy for us to recognize related classes in our code. 
  * The second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase.

  ##### Modules as Containers (Module Methods)

  * This involves using modules to house other methods.
  * This is very useful for methods that seem out of place within your code.



---

#### Method Lookup Path  

* Ruby has a distinct lookup path that it follows each time a method is called.
* We can use the `ancestors` method on any class to find out the method lookup chain.  
* The method lookup pat is the order in which classes are inspected when you call a method.
* The order in which we include modules is important. Ruby actually looks at the last module we included _first_. This means that in the rare occurrence that the modules we mix in contain a method with the same name, the last module included will be consulted first. 
* Modules included in a superclass will also make it on to the method lookup path.



---

#### self

* To disambiguate from creating a local variable, we sometimes need to prefix our getter- and setter-method calls with `self` to let Ruby know that we're calling a method.
* When defining a class method, we prepend the method name with the reserved word `self.`.
* We use `self` to specify a certain scope for our program. `self` can refer to different things depending on where it is used.
* Here are at least two clear use cases for `self`: 1) use `self` when calling setter methods from within the class to allow Ruby to disambiguate between initializing a local variable and calling a setter method; and 2) use `self` for class method definitions.
* From within the class, when an instance method calls `self`, it is returning the _calling object_.
* So just be clear, from within a class...
  1. `self`, inside of an instance method, references the instance (object) that called the method--the calling object.
  2. `self`, outside of an instance method, references the class and can be used to define class methods.
* So we can see that `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behaviour. `self` changes depending on the scope it is used in, so pay attention to see if you're inside an instance method or not.