## Lecture: Inheritance

Class based inheritance works great when it's used to model hierarchical domains. Let's take a look at a few practice problems. Suppose we're building a software system for a pet hotel business, so our classes deal with pets.



1. Given this class:

```ruby
class Dog
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak 				# => "bark!"
puts teddy.swim 				# => "swimming!"
```

One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviours. For example, bulldogs can't swim, but all other dogs can.



Create a sub-class from `Dog` called `Bulldog` overriding the `swim` method to return "can't swim!"



My solution:

```ruby
class Bulldog < Dog
  def swim
    "can't swim!"
  end
end
```

Launch school solution is the same.

---

2. Let's create a few more methods for our `Dog` class.

```ruby
class Dog
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end
  
  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
  
  def fetch
    'fetching!'
  end
end
```

Create a new class called `Cat`, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in `Dog` into `Cat`; try to come up with some class hierarchy.



My solution:

```ruby
class Pets
  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
end

class Dog < Pets
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end
  
  def fetch
    'fetching!'
  end
end

class Cat < Pets
  def speak
    'meow!'
  end
end
```

Pretty much the same as Launch School's solution.

---

3. Draw a class hierachy diagram of the classes from step #2.



`Pets` would be at the top of the hierarchy and would have branches extending downwards, one for `Dog` and one for `Cat`.

---

4. What is the _method lookup path_ and how is it important?



My response: the method lookup path is the hierarchy of inheritance for a specific class. It is important because it reveals the path by which Ruby will search for a given method call, starting with the object's class and then moving up the inhertiance hiearchy to the next class until the method that was called is found.



Launch School's solution: The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke. For example, say you have a `Bulldog` object called `bud` and you call: `bud.swim`. Ruby will first look for a method called `swim` in the `Bulldog` class, then traverse up the chain of super-classes; it will invoke the first method called `swim` and stop its traversal.



In our simple hierarchy, it's pretty straight forward. Things can quickly get complicated in larger libraries or frameworks. To see the method lookup path, we can use the `.ancestors` class method.

```ruby
Bulldog.ancestors 		# => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]
```

Note that this method returns an array, and that all classes sub-class from `Object`. Don't worry about `Kernel` or `BasicObject` for now.



