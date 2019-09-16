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

```ruby
class MyCar
  attr_accessor :color	# additional code for being able to change and view the color
  attr_reader :year			# additional code for viewing, but not modifying, the year
  attr_reader :model 		# same as for the year
  
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
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

MyCar.gas_mileage(13, 351) 	# => "27 miles per gallon of gas"
```

2. Override the to_s method to create a user friendly print out of your object.

```ruby
class MyCar
  
  # code omitted for brevity
  
  def to_s
    puts "My car is a #{color} #{year} #{model}"
  end
end
```

3. When running the following code...

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

We get the following error...

```ruby
test.rb:9:in `<main>': undefined method `name=' for
	#<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
```

Why do we get this error and how do we fix it?



My response: We get this error because we did not include a setter method for the instance variables of the `Person` class. We can fix this by changing the `attr_reader` method to a `attr_accessor` method. Thus, we have:

```ruby
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

Launch School's explanation: We get this error because `attr_reader` only creates a getter method. When we try to reassign the name instance variable to `"Bob"`, we need a setter method called `name==`. We can get this by changing `attr_reader` to `attr_accessor` or `attr_writer` if we don't intend to use the getter functionality.

```ruby
class Person
  attr_accessor :name
  # attr_writer :name ## => This also works but doesn't allow getter access
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

---

#### Class Inheritance

---

* **Inheritance** is when a class **inherits** behaviour from another class. The class that is inheriting behaviour is called the subclass and the class it inherits from is called the superclass.
* We use inheritance as a way to extract common behaviours from classes that share that behaviour, and move it to a superclass. This lets us keep logic in one place. Let's take a look at an example.

---

**Class Inheritance**

* Here, we're extracting the `speak` method to a superclass `Animal`, and we use inheritance to make that behaviour available to `GoodDog` and `Cat` classes.

```ruby
# good_dog_class.rb

class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak 					# => Hello!
puts paws.speak 						# => Hello!
```

* We use the `<` symbol to signify that the `GoodDog` class is inheriting from the `Animal` class. This means that all of the methods in the `Animal` class are available to the `GoodDog` class for use. We also created a new class called `Cat` that inherits from `Animal` as well. We've eliminated the `speak` method from the `GoodDog` class in order to use the `speak` method from `Animal`.
* When we run this code we see the correct output. Both classes are now using the superclass `Animal`'s `speak` method.
* But what if we want to use the original `speak` method from the `GoodDog` class only. Let's add it back and see what happens.

```ruby
# good_dog_class.rb

class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name
  
  def initialize(n)
    self.name = n
  end
  
  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak 					# => Sparky says arf!
puts paws.speak 						# => Hello!
```

* In the `GoodDog` class, we're **overriding** the `speak` method in the `Animal` class because Ruby checks the object's class first for the method before it looks in the superclass. So, that means when we wrote the code `sparky.speak`, it first looked at `sparky`'s class, which is `GoodDog`. It found the `speak` method there and used it. When we wrote the code `paws.speak`, Ruby first looked at `paws`'s class, which is `Cat`. It did not find a `speak` method there, so it continued to look in `Cat`'s superclass, `Animal`. It found a `speak` method in `Animal`, and used it. We'll talk about this _method lookup_ path more in depth in a bit.
* Inheritance can be a great way to remove duplication in your code base. There is an acronym that you'll see often in the Ruby community, "DRY". This stands for "Don't Repeat Yourself". It means that if you find yourself writing the same logic over and over again in your programs, there are ways to extract that logic to one place for reuse.

---

**super**

* Ruby provides us with a built-in function called `super` that allows us to call methods up the inheritance hierarchy. When you call `super` from within a method, it will search the inheritance hierarchy for a method by the same name and then invoke it. Let's see a quick example of how this works:

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
	def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak 				# => "Hello! from GoodDog class"
```

* In the above example, we've created a simple `Animal` class with a `speak` instance method. We then created `GoodDog` which subclasses `Animal` also with a `speak` instance method to override the inherited version. However, in the subclass' `speak` method we use `super` to invoke the `speak` method from the superclass, `Animal`, and then we extend the functionality by appending some text to the result.
* Another more common way of using `super` is with `initialize`. Let's see an illustration of that:

```ruby
class Animal
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown") # => #<GoodDog:0x007fb401e6718 @color="brown", @name="brown">
```

* The interesting concept we want to explain is the use of `super` in the `GoodDog` class. In this example, we're using `super` with no arguments. However, the `initialize` method, where `super` is being used, takes an argument and adds a new twist to how `super` is invoked. Here, in addition to the default behaviour, `super` automatically forwards the arguments that were passed to the method from which `super` is called (`initialize` method in `GoodDog` class). At this point, `super` will pass the `color` argument in the `initialize` defined in the subclass to that of the `Animal` superclass and invoke it. That explains the presence of `@name="brown"` when the `bruno` instance is created. Finally, the subclass' `initialize` continues to set the `@color` instance variable.
* When called with specific arguments, eg. `super(a, b)`, the specified arguments will be sent up the method lookup chain. Let's see a quick example:

```ruby
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear") 	# => #<BadDog:0x007fb402beb68 @age=2, @name="bear">
```

* This is similar to our previous example, with the difference being that `super` takes an argument, hence the passed in argument is sent to the superclass. Consequently, in this example when a `BadDog` class is created, the passed in `name` argument ("bear") is passed to the superclass and set to the `@name` instance variable.

---

**Mixing in Modules**

* Another way to DRY up your code in Ruby is to use **modules**. We've already seen a little bit of how to use modules, but we'll give a few more examples here.
* Extracting common methods to a superclass, like we did in the previous section, is a great way to model concepts that are naturally hierarchical. We gave the example of animals. We have a generic superclass called `Animal` that can keep all basic behaviour of all animals. We can then expand on the model a little and have, perhaps, `Mammal` and `Fish` subclasses of `Animal`. 
* We can imagine that all `Fish` objects are related to animals that live in the water, so perhaps a `swim` method should be in the `Fish` class. We can also imagine that all `Mammal` objects will have warm blood, so we can create a method called `warm_blooded?` in the `Mammal` class and have it return `true`. Therefore, the `Cat` and `Dog` objects will have access to the `warm_blooded?` method which is automatically inherited from `Mammal` by the `Cat` and `Dog` classes, but they won't have access to the methods in the `Fish` class.
* This type of hierarchical modeling works, to some extent, but there are always exceptions. For example, we put the `swim` method in the `Fish` class, but some mammals can swim as well. We don't want to move the `swim` method into `Animal` because not all animals swim, and we don't want to create another `swim` method in `Dog` because that violates the DRY principle. For concerns such as these, we'd like to group them into a module and then _mix in_ that module to the classes that require those behaviours. Here's an example:

```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable 			# mixing in Swimmable module
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable 			# mixing in Swimmable module
end
```

* And now `Fish` and `Dog` objects can swim, but objects of other classes won't be able to:

```ruby
sparky = Dog.new
neemo = Fish.new
paws = Cat.new

sparky.swim 			# => I'm swimming!
neemo.swim 				# => I'm swimming!
paws.swim					# => NoMethodError: undefined method `swim` for #<Cat:0x007fc453152308>
```

* Using modules to group common behaviours allows us to build a more powerful, flexible and DRY design.
* _Note: A common naming convention for Ruby is to use the "able" suffix on whatever verb describes the behaviour that the module is modelling. You can see this convention with our `Swimmable` module. Likewise, we could name a module that describes "walking" as `Walkable`. Not all modules are named in this manner, however, it is quite common._

---

**Inheritance vs Modules**

* Now that you know the two primary ways that Ruby implements inheritance, class inheritance and mixing in modules, you may wonder when to use one vs the other. Here are a couple of things to remember when evaluating those two choices.
  * You can only subclass from one class. But you can mix in as many modules as you'd like.
  * If it's an "is-a" relationship, choose class inheritance. If it's a "has-a" relationship, choose modules. Example: a dog "is an" animal; a dog "has an" abilit to swim.
  * You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for name spacing and grouping common methods together.
* As you get better at OO design, you'll start to develop a feel for when to use class inheritance versus mixing in modules.

---

**Method Lookup Path**

* Now that you have a grasp on both inheritance and mixing. Let's put them both together to see how that affects the _method lookup path_. Recall the method lookup path is the order in which classes are inspected when you call a method. Let's take a look at the example code below.

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing"
  end
end

class Animal
  include Walkable
  
  def speak
    "I'm an animal, and I speak!"
  end
end
```

* We have three modules and one class. We've mixed in one module into the `Animal` class. The method lookup path is the path Ruby takes to look for a method. We can see this path with the `ancestors` class method.

```ruby
puts "---Animal method lookup---"
puts Animal.ancestors
```

* The output looks like this:

```
---Animal method lookup---
Animal
Walkable
Object
Kernel
BasicObject
```

* This means that when we call a method of any `Animal` object, first Ruby looks in the `Animal` class, then the `Walkable` module, then the `Object` class, then the `Kernel` module, and finally the `BasicObject` class.

```ruby
fido = Animal.new
fido.speak 							# => I'm an animal, and I speak!
```

* Ruby found the `speak` method in the `Animal` class and looked no further.

```ruby
fido.walk 							# => I'm walking.
```

* Ruby first looked for the `walk` instance method in `Animal`, and not finding it there, kept looking in the next place according to our list, which is the `Walkable` module. It saw a `walk` method there, executed it, and stopped looking further.

```ruby
fido.swim
	# => NoMethodError: undefined method `swim' for #<Animal:0x007f92832625b0>
```

* Ruby traversed all the classes and modules in the list, and didn't find a `swim` method, so it threw an error.
* Let's add another class to the code above. This class will inherit from the `Animal` class and mix in the `Swimmable` and `Climbable` modules.

```ruby
class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
```

* And this is the output we get:

```
---GoodDog method lookup---
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
```

* There are several interesting things about the above output. First, this tells us that the order in which we include modules is important. Ruby actually looks at the last module we included _first_. This means that in the rare occurrence that the modules we mix in contain a method with the same name, the last module included will be consulted first. The second interesting thing is that the module included in the superclass made it on to the method lookup path. That means that all `GoodDog` objects will have access to not only `Animal` methods, but also methods defined in the `Walkable` module, as well as all other modules mixed in to any of its superclasses.
* Sometimes when you're working on a large project, it can be confusing where all these methods are coming from. By understanding the method lookup path, we can have a better idea of where and how all available methods are organized.

---

**More Modules**

* We've already seen how modules can be used to mix-in common behaviour into classes. Now we'll see two more uses for modules.
* The first case we'll discuss is using modules for **namespacing**. In this context, namespacing means organizing similar classes under a module. In other words, we'll use modules to group related classes. Therein lies the first advantage of using modules for namespacing. It becomes easy for us to recognize related classes in our code. The second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase. Here's how we do it:

```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end
  
  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```

* We call classes in a module by appending the class name to the module name with two colons (`::`)

```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!') 				# => "Arf!"
kitty.say_name('kitty') 		# => "kitty"
```

* The second use case for modules we'll look at is using modules as a **container** for methods, called module methods. This involves using modules to house other methods. This is very useful for methods that seem out of place within your code. Let's use our `Mammal` module to demonstrate:

```ruby
module Mammal
  ...
    
  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```

* Defining methods this way with a module means we can call them directly from the module:

```ruby
value = Mammal.some_out_of_place_method(4)
```

* We can also call such methods by doing:

```ruby
value = Mammal::some_out_of_place_method(4)
```

* although the former is the preferred way.

---

**Private, Protected, and Public**

* Right now, all the methods in our `GoodDog` class are public methods.
* A **public method** is a method that is available to anyone who knows either the class name or the object's name. These methods are readily available for the rest of the program to use and comprise the class's _interface_ (that's how other classes and objects will interact with this class and its objects).
* **private methods** are methods doing work in the class but don't need to be available to the rest of the program. To define private methods we use the reserved word `private` in our program and anything below it is private (unless another reserved word is placed after it to negate it).
* In our `GoodDog` class we have one operation that takes place that we could move into a private method. When we initialize an object, we calculate the dog's age in Dog years. Let's refactor this logic into a method and make it private so nothing outside of the class can use it.

```ruby
class GoodDog
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(n, a)
    self.name = n
    self.age = a
  end
  
  private
  
  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years
```

* We get the error message:

```ruby
NoMethodError: private method `human_years' called for
	#<GoodDog:0x007f8f431441f8 @name="Sparky", @age=4>
```

* We have made the `human_years` method private by placing it under the `private` reserved word. So what is it good for if we can't call it? `private` methods are only accessible from other methods in the class. For example, given the above code, the following would be allowed:

```ruby
# assume the method definition below is above the "private" keyword

def public_disclosure
  "#{self.name} in human years is #{human_years}"
end
```

* Note that in this case, we can _not_ use `self.human_years`, because the `human_years` method is private. Remember that `self.human_years` is equivalent to `sparky.human_years`, which is not allowed for private methods. Therefore, we have to just use `human_years`. In summary, private methods are not accessible outside of the class defintion at all, and are only accessible from inside the class when called without `self`.
* Public and private methods are most common, but in some less common situations, we'll want an in-between approach. We can use the `protected` keyword to create **protected** methods. The easiest way to understand protected methods is to follow these two rule:
  * from outside the class, `protected` methods act just like `private` methods.
  * from inside the class, `protected` methods are accessible just like `public` methods.
* Let's take a look at some examples:

```ruby
class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end
  
  protected
  
  def a_protected_method
    "Yes, I'm protected!"
  end
end
```

* Let's create an `Animal` object and test it out.

```ruby
fido = Animal.new
fido.a_public_method 			# => Will this work? Yes, I'm protected!
```

* The above line of code shows us that we can call a `protected` method from within the class, even with `self` prepended. What about outside of the class?

```ruby
fido.a_protected_method
	# => NoMethodError: protected method `a_protected_method' called for #<Animal:0x007fb174157110>
```

* This demonstrates the second rule, that we can't call protected methods from outside of the class. The two rules for `protected` methods apply within the context of inheritance as well.
* There are some exceptions to this rule, but we won't worry about that yet. Protected methods are not used often in practice and that knowledge isn't transferable to other languages, so if you remember those two rules about protected methods, that should be good enough for the time being.

---

**Accidental Method Overriding**

* It's important to remember that every class you create inherently subclasses from class Object. The `Object` class is built into Ruby and comes with many critical methods.

```ruby
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

Parent.superclass 			# => Object
```

* This means that methods defined in the `Object` class are available in _all classes_.
* Further, recall that through the magic of inheritance,  a subclass can override a superclass's method.

```ruby
class Child < Parent
  def say_hi
    p "Hi from Child."
  end
end

child = Child.new
child.say_hi 				# => "Hi from Child."
```

* This means that, if you accidentally override a method that was originally defined in the `Object` class, it can have far-reaching effects on your code. For example, `send` is an instance method that all classes inherit from `Object`. If you defined a new `send` instance method in your class, all objects of your class will call your custom `send` method, instead of the one in class `Object`, which is probably the one they mean to call.
* Object `send` serves as a way to call a method by passing it a symbol or a string which represents the method you want to call. The next couple of arguments will represent the method's arguments, if any. Let's see how `send` normally works by making use of our `Child` class:

```ruby
son = Child.new
son.send :say_hi 				# => "Hi from Child."
```

* Let's see what happens when we define a `send` method in our `Child` class and then try to invoke `Object`'s `send` method:

```ruby
class Child
  def say_hi
    p "Hi from Child."
  end
  
  def send
    p "send from Child..."
  end
end

lad = Child.new
lad.send :say_hi
```

* Normally we would expect the output of this call to be `"Hi from Child."` but upon running the code we get a completely different result:

```ruby
ArgumentError: wrong number of arguments (1 for 0)
  from (pry):12:in `send'
```

* In our example, we're passing `send` one argument even though our overridden `send` method does not take any arguments. Let's take a look at another example by exploring Object's `instance_of?` method. What this handy method does is to return `true` if an object is an instance of a given class and `false` otherwise. Let's see it in action:

```ruby
c = Child.new
c.instance_of? Child 			# => true
c.instance_of? Parent 		# => false
```

* Now let's override `instance_of?` within `Child`:

```ruby
class Child
  # other methods omitted
  
  def instance_of?
    p "I am a fake instance"
  end
end

heir = Child.new
heir.instance_of? Child
```

* Again, we'll see something completely different though our intention was to use Object's `instance_of?` method:

```ruby
ArgumentError: wrong number of arguments (1 for 0)
  from (pry):22:in `instance_of?'
```

* That said, one `Object` instance method that's easily overridden without any major side-effect is the `to_s` method. You'll normally want to do this when you want a different string representation of an object. 
* Overall, it's important to familiarize yourself with some of the common `Object` methods and make sure to not accidentally override them as this can have devastating consequences for your application.

---

**Exercises**









 