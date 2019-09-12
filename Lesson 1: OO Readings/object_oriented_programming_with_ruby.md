## Object Oriented Programming with Ruby

### Object Oriented Programming

---

#### The Object Model

---

**Why Object Oriented Programming?**

* **Objected Oriented Programming**, often referred to as **OOP**, is a programming paradigm that was created to deal with the growing complexity of large software systems.
* Programmers needed a way to section off areas of code that performed certain procedures so that their programs could become the interaction of many small parts, as opposed to one massive blob of dependency.
* **Encapsulation** is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. It is what defines the boundaries in your application and allows your code to achieve new levels of complexity.

* Another benefit of creating objects is that they allow the programmer to think on a new level of abstraction. Objects are represented as real-world nouns and can be given methods that describe the behavior the programmer is trying to represent.
* **Polymorphism** is the ability for data to be represented as many different types. "Poly" stands for "many" and "morph" stands for "forms". OOP gives us flexibility in using pre-written code for new purposes.

* The concept of **inheritance** is used in Ruby where a class inherits the behaviors of another class, referred to as the **superclass**. This gives Ruby programmers the power to define basic classes with large reusability and smaller **subclasses** for more fine-grained, detailed behaviors.
* Another way to apply polymorphic structure to Ruby programs is to use a `Module`. Modules are similar to classes in that they contain shared behavior. However, you cannot create an object with a module. A module must be mixed in with a class using the `include` method invocation. This is called a **mixin**. After mixing in a module, the behaviors declared in that module are available to the class and its objects.

---

**What are Objects?**

* Everything in Ruby is an object. Objects are created from classes. Think of classes as molds and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class.

---

**Classes Define Objects**

* Ruby defines the attributes and behaviors of its objects in **classes**. 
* To define a class, we use syntax similar to defining a method. We replace the `def` with `class` and use the CamelCase naming convention to create the name. We then use the reserved word `end` to finish the definition.
* Ruby file names should be in snake_case, and reflect the class name. So in the below example, the file name is `good_dog.rb` and the class name is `GoodDog`.

```ruby
# good_dog.rb

class GoodDog
end

sparky = GoodDog.new
```

* In the above example, we created an instance of our `GoodDog` class and stored it in the variable `sparky`. We now have an object. We say that `sparky` is an object or instance of class `GoodDog`. This entire workflow of creating a new object or instance from a class is called **instantiation**, so we can also say that we've instantiated an object called `sparky` from the class `GoodDog`. 
* The important fact here is that an object is returned by calling the class method `new`.

---

**Modules**

* As we mentioned earlier, modules are another way to achieve polymorphism in Ruby.
* A **module** is a collection of behaviors that is usable in other classes via **mixins**. A module is "mixed in" to a class using the `include` method invocation.
* Let's say we wanted our `GoodDog` class to have a `speak` method but we have other classes that we want to use a speak method with too. Here's how we'd do it.

```ruby
# good_dog.rb

module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!")			# => Arf!
bob = HumanBeing.new
bob.speak("Hello!")				# => Hello!
```

* Note that in the above example, both the `GoodDog` object, which we're calling `sparky`, as well as the `HumanBeing` object, which we're calling `bob`, have access to the `speak` instance method.
* This is possible through "mixing in" the module `Speak`. It's as if we copy-pasted the `speak` method into the `GoodDog` and `HumanBeing` classes.

---

**Method Lookup**

* When you call a method, how does Ruby know where to look for that method? Ruby has a distinct lookup path that it follows each time a method is called.
* Let's use our program from above to see what the method lookup path is for our `GoodDog` class. We can use the `ancestors` method on any class to find out the method lookup chain.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors
```

* The output looks like this:

```ruby
---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject
```

* The `Speak` module is placed right in between our custom classes (i.e., `GoodDog` and `HumanBeing`) and the `Object` class that comes with Ruby. In inheritance you'll see how the method lookup chain works when working with both mixins and class inheritance.
* This means that since the `speak` method is not defined in the `GoodDog` class, the next place it looks is the `Speak` module. This continues in an ordered, linear fashion, until the method is either found, or there are no more places to look.

---

**Summary**

* The next couple of chaters will dive into more details.

---

**Exercises**

1. How do we create an object in Ruby? Give an example of the creation of an object.



A: Everything in Ruby is an object. I can create an object by assigning a value to a particular type of object. For example,

```ruby
str = "hello world" # <= this is a String object
seven = 7 					# <= this is an Integer object
```

Launch School's answer: we create an object by defining a class and instantiating it by using the `.new` method to create an instance, also known as an object.

```ruby
class MyClass
end

my_obj = MyClass.new
```



2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.



A: A module is a collection of behaviors that is usable in other classes. It allows us to section off different types of behaviors and use them only for classes that we specifically designate. Modules can be used with classes via mixins, which require that we invoke the `include` method.

```ruby
module Calculate
  def add(a, b)
    a + b
  end
end

class MyClass
  include Calculate
end 
```

Launch School's answer: a module allows us to group reusable code into one place. We use modules in our classes by using the `include` method invocation, followed by the module name. Modules are also used as a namespace.

```ruby
module Study
end

class MyClass
  include Study
end

my_obj = MyClass.new
```

---

#### Classes and Objects: Part I

---

**States and Behaviors**

* We use classes to create objects.
* When defining a class, we typically focus on two things: _states_ and _behaviors_. States track attributes for individual objects. Behaviors are what objects are capable of doing.
* instance variables keep track of state.
* instance methods expose behavior for objects.

---

**Initializing a New Object**

* a _constructor_ is a method that gets triggered whenever we create a new object.

---

**Instance Variables**

* Let's create a new object and instantiate it with some state, like a name.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end
```

* You'll notice something new here. The `@name` variable looks different because it has the `@` symbol in front of it. This is called an **instance variable**. It is a variable that exists as long as the object instance exists and it is one of the ways we tie data to objects. It does not "die" after the initialize method is run. It "lives on", to be referenced, until the object instance is destroyed. In the above example, our `initialize` method takes a parameter called `name`. You can pass arguments into the `initialize` method through the `new` method. Let's create an object using the `GoodDog` class from above:

```ruby
sparky = GoodDog.new("Sparky")
```

* Here, the string "Sparky" is being passed from the `new` method through to the `initialize` method, and is assigned to the local variable `name`. Within the constructor (i.e., the `initialize` method), we then set the instance variable `@name` to `name`, which results in assigning the string "Sparky" to the `@name` instance variable.
* From that example, we can see that instance variables are responsible for keeping track of information about the _state_ of an object. In the above line of code, the name of the `sparky` object is the string "Sparky". This state for the object is tracked in the instance variable, `@name`. If we created another `GoodDog` object, for example, with `fido = GoodDog.new('Fido')`, then the `@name` instance variable for the `fido` object would contain the string "Fido". Every object's state is unique, and instance variables are how we keep track.

---

**Instance Methods**

* Right now, our `GoodDog` class can't really do anything. Let's give it some behaviours.

```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end
  
  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
sparky.speak
```

* When you run this program, nothing happens. This is because the `speak` method returned the string "Arf!", but we now need to print it out. So we should add `puts` in front of it, like this:

```ruby
puts sparky.speak 				# => Arf!
```

* Now, we should see that the output of our program is the string "Arf!". We told `sparky` to speak and he did. Now, suppose we have another `GoodDog` object:

```ruby
fido = GoodDog.new("Fido")
puts fido.speak 						# => Arf!
```

* Our second `fido` object can also perform `GoodDog` behaviours. So again, all objects of the same class have the same behaviours, though they contain different states; here, the differing state is the name.
* What if we wanted to not just say "Arf!", but say "Sparky says are!"? In our instance methods, which is what all the methods are so far, we have access to instance variables. So, we can use string interpolation and change our `speak` method to this (other code omitted):

```ruby
# good_dog.rb

def speak
  "#{@name} says arf!"
end
```

* And now, we can expose information about the state of the object using instance methods.

```ruby
puts sparky.speak 								# => "Sparky says arf!"
puts fido.speak 									# => "Fido says arf!"
```

---

**Accessor Methods**

* What if we wanted to print out only `sparky`'s name? We could try the code below (other code omitted):

```ruby
puts sparky.name
```

* However, we get an error.
* A `NoMethodError` means that we called a method that doesn't exist or is unavailable to the object. If we want to access the object's name, which is stored in the `@name` instance variable, we have to create a method that will return the name. We can call it `get_name`, and its only job is to return the value in the `@name` instance variable.

```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end
  
  def get_name
    @name
  end
  
  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
```

* Ok, we've added our `get_name` method and it should return the value of our `@name` instance variable. Let's run this code and see if it works.
* This is what we got back.

```ruby
Sparky says arf!
Sparky
```

* It worked! We now have a _getter_ method. But what if we wanted to change `sparky`'s name? That's when we reach for a _setter_ method. It looks a lot like a getter method but with one small difference. Let's add it.

```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end
  
  def get_name
    @name
  end
  
  def set_name=(name)
    @name = name
  end
  
  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
sparky.set_name = "Spartacus"
puts sparky.get_name
```

* The output of this code is:

```ruby
Sparky says arf!
Sparky
Spartacus
```

* As you can see, we've successfully changed `sparky`'s name to the string "Spartacus". The first thing you should notice about the _setter_ method `set_name=` is that Ruby gives us a special syntax to use it. To use the `set_name=` method normally, we would expect to do this: `sparky.set_name=("Spartacus")`, where the entire "set_name=" is the method name, and the string "Spartacus" is the argument being passed in to the method. Ruby recognizes this is a _setter_ method and allows us to use the more natural assignment syntax: `sparky.set_name = "Spartacus"`. When you see this code, just realize there's a method called `set_name=` working behind the scenes, and we're just seeing some Ruby _syntactical sugar_.
* Finally, as a convention, Rubyists typically want to name those _getter_ and _setter_ methods using the same name as the instance variable they are exposing and setting. We'll make the change to our code as well:

```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end
  
  def name												# This was renamed from "get_name"
    @name
  end
  
  def name=(n)										# This was renamed from "set_name="
    @name = n
  end
  
  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name					# => "Sparky"
sparky.name = "Spartacus"
puts sparky.name					# => "Spartacus"
```

* You'll notice that writing those _getter_ and _setter_ methods took up a lot of room in our program for such a simple feature. And if we had other states we wanted to track, like height or weight, the class would be even longer. Because these methods are so commonplace, Ruby has a built-in way to automatically create these _getter_ and _setter_ methods for us, using the **attr_accessor** method. Check out this refactoring of the code from above.

```ruby
# good_dog.rb

class GoodDog
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name						# => "Sparky"
sparky.name = "Spartacus"
puts sparky.name						# => "Spartacus"
```

* Our output is the same! The `attr_accessor` method takes a symbol as an argument, which it uses to create the method name for the `getter` and `setter` methods. That one line replaced two method definitions.
* But what if we only want the `getter` method without the `setter` method? Then we would want to use the `attr_reader` method. It works the same way but only allows you to retreive the instance variable. And if you only want the setter method, you can use the `attr_writer` method. All of the `attr_*` methods take a `Symbol` as parameters; if there are more states you're tracking, you can use this syntax:

```ruby
attr_accessor :name, :height, :weight
```

---

#### Exercises

1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to `0` during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

```ruby
class MyCar
  attr_accessor :year, :color, :model
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def speed_up
    @speed += 1
  end
  
  def brake
    @speed -= 1
  end
  
  def turn_off
    @speed = 0
  end
end
```

Launch School's solution:

```ruby
class MyCar
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed
```

2. Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

```ruby
class MyCar
  attr_accessor :color		# additional code for being able to change and view the color
  attr_reader :year				# additional code for viewing, but not modifying, the year
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
end

car = MyCar.new(2000, 'Toyota Camry', 'black')
car.color # => 'black'
car.year  # => 2000
car.color = 'white'
car.color # => 'white'
car.year = 2001 # => NoMethodError
```

3. You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called `spray_paint` that can be called on an object and will modify the color of the car.

```ruby
class MyCar
  attr_accessor :color		# additional code for being able to change and view the color
  attr_reader :year				# additional code for viewing, but not modifying, the year
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
  
  def spray_paint(paint_color)
    @color = paint_color
  end
end

car = MyCar.new(2000, "Toyota Camry", 'black')
car.color # => 'black'
car.spray_paint('white')
car.color # => 'white'
```

Launch School's solution

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year
  
  # ... rest of class left out for brevity
  
  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
end

lumina.spray_paint('red')	 # => "Your new red paint job looks great!"
```

---

#### Classes and Objects: Part II

---

**Class Methods**

* **Class methods** are methods we can call directly on the class itself, without having to instantiate any objects.
* When defining a class method, we prepend the method name with the reserved word `self.`, like this:

```ruby
# good_dog.rb
# ... rest of code ommitted for brevity

def self.what_am_i 					# Class method definition
  "I'm a GoodDog class!"
end
```

* Then when we call the class method, we use the class name `GoodDog` followed by the method name, without even having to instantiate any objects, like this:

```ruby
GoodDog.what_am_i 					# => I'm a GoodDog class!
```

* Class methods are where we put functionality that does not pertain to individual objects. Objects contain state, and if we have a method that does not need to deal with states, then we can just use a class method, like our simple example. We'll take a look at a more useful example in the next section.

---

**Class Variables**

* Just as instance variables capture information related to specific instances of classes (i.e., objects), we can create variables for an entire class that are appropriatelyl named **class variables**.
* Class variables are created using two `@` symbols like so: `@@`. 

```ruby
class GoodDog
  @@number_of_dogs = 0
  
  def initialize
    @@number_of_dogs += 1
  end
  
  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs 	# => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs 	# => 2
```

* We have a class variable called `@@number_of_dogs`, which we initialize to 0. Then in our constructor (the `initialize` method), we increment that number by 1. 
* Remember that `initialize` gets called every time we instantiate a new object via the `new` method. This also demonstrates that we can access class variables from within an instance method (`initialize` is an instance method). 
* Finally, we just return the value of the class variable in the class method `self.total_number_of_dogs`. 
* This is an example of using a class variable and a class method to keep track of a class level detail that pertains only to the class, and not to individual objects.

---

**Constants**

* **constants** are variables that you never want to change; while constants can be created in Ruby by using an upper case letter at the beginning of the variable name, Rubyists generally make the entire variable uppercase.

```ruby
class GoodDog
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age 						# => 28
```

* Here we used the constant `DOG_YEARS` to calculate the age in dog years when we created the object, `sparky`. Note that we used the setter methods in the `initialize` method to initialize `@name` and `@age` instance variables given to us by the `attr_accessor` method. We then used the `age` getter method to retrieve the value from the object.

---

**The to_s Method**

* By default, the `to_s` method returns the name of the object's class and an encoding of the object id.
* `puts sparky` is equivalent to `puts sparky.to_s`.
* There's another method called `p` that's very similar to `puts`, except it doesn't call `to_s` on its argument; it calls another built-in Ruby instance method called `inspect`. The `inspect` method is very helpful for debugging purposes, so we don't want to override it.
* `p sparky` is equivalent to `puts sparky.inspect`.
* Another important attribute of the `to_s` method is that it's also automatically called in string interpolation (i.e. `"#{}"`). We've seen this before when using integers or arrays in string interpolation.
* In summary, the `to_s` method is called automatically on the object when we use it with `puts` or when used with string interpolation. This fact may seem trivial at the moment, but knowing when `to_s` is called will help us understand how to read and write better OO code.

---

**More About self**

* We use `self` to specify a certain scope for our program.
* `self` can refer to different things depending on where it is used.
* So far, we've seen two clear use cases for `self`:

1. Use `self` when calling setter methods from within the class. In our earlier example we showed that `self` was necessary in order for our `change_info` method to work properly. We had to use `self` to allow Ruby to disambiguate between initializing a local variable and calling a setter method.
2. Use `self` for class method definitions.

* Let's play around with `self` to see why the above two rules work. Let's assume the following code:

```ruby
class GoodDog
  attr_accessor :name, :height, :weight
  
  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
  
  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
  
  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end
```

* This is our standard `GoodDog` class, and we're using `self` whenever we call an instance method from within the class. We know the rule to use `self`, but what does `self` really represent here? Let's add one more instance method to help us find out.

```ruby
# good_dog.rb

class GoodDog
  # ... rest of code omitted for brevity
  
  def what_is_self
    self
  end
end
```

* Now we can instantiate a new `GoodDog` object.

```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```

* That's interesting. So from within the class, when an instance method calls `self`, it is returning the _calling object_, so in this case, it's the `sparky` object. Therefore, from within the `change_info` method, calling `self.name=` is the same as calling `sparky.name=`. Now we understand why using `self` to call instance methods from within the class works the way it does!
* The other place we use `self` is when we're defining class methods, like this:

```ruby
class MyAwesomeClass
  def self.this_is_a_class_method
  end
end
```

* When `self` is prepended to a method definition, it is defining a **class method**. 
* In our `GoodDog` class method example, we defined a class method called `self.total_number_of_dogs`. This method returned the value of the class variable `@@number_of_dogs`. How is this possible? Let's use code to take a look:

```ruby
class GoodDog
  # ... rest of code omitted for brevity
  puts self
end
```

* Then you can test it in "irb" just by pasting the above code into irb and typing "GoodDog":

```ruby
irb :001 > GoodDog
=> GoodDog
```

* So you can see that `self`, inside a class but outside an instance method, is actually referring to the class itself. Therefore, a method definition prefixed with `self` is the same as defining the method on the class. That is, `def self.a_method` is equivalent to `def GoodDog.a_method`. That's why it's a class method; it's actually being defined on the class.
* So just to be clear, from within a class...

1. `self`, inside of an instance method, references the instance (object) that called the method--the calling object. Therefore, `self.weight=` is the same as `sparky.weight=`, in our example.
2. `self`, outside of an instance method, references the class and can be used to define class methods. Therefore, `def self.name=(n)` is the same as `def GoodDog.name=(n)`, in our example.

* So we can see that `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behaviour. `self` changes depending on the scope it's defined in, so pay attention to see if you're inside an instance method or not. `self` is a tricky concept to grasp in the beginning, but the more often you see its use, the more you will understand object oriented programming. If the explanations don't quite make sense, just memorize those two rules above for now.

---

**Exercises**

1. Add a class method to your MyCar class that calculates the gas mileage of any car.



