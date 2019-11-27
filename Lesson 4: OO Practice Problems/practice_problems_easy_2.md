## Practice Problems: Easy 2

###### Question 1  

You are given the following code:

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```

What is the result of calling

```ruby
oracle = Oracle.new
oracle.predict_the_future
```

**My Response:**  

The result will be a print out of `"You will` followed by one of the three elements of the array contained in the `choices` method.

```ruby
"You will eat a nice lunch"
# or
"You will take a nap soon"
# or
"You will stay at work late"
```

---

###### Question 2  

We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class.

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```

What is the result of the following:

```ruby
trip = RoadTrip.new
trip.predict_the_future
```

**My Response:**  

The result will be the string of the form `"You will <something>"` where `<something>` will be replaced by one of the three elements in the array defined within the `choices` method within the `Oracle` class, not the `RoadTrip` class.  

Turns out that I was wrong. The `choices` method from the `RoadTrip` class is the one that is called by the `predict_the_future` method, not the one from the `Oracle` class.  

**Launch School's Response:**  

Now the string returned will be of the form `"You will <some trip>"` where the trip is taken from the choices defined by the `choices` method of `RoadTrip`.  

Why does this happen? Doesn't the `choices` called in the implementation of Oracle's `predict_the_future` look in the `Oracle` class for a `choices` method? The answer is that since we're calling `predict_the_future` on an instance of `RoadTrip`, every time Ruby tries to resolve a method name, it will start with the methods defined on the class you are calling. So even though the call to `choices` happens in a method defined in `Oracle`, Ruby will first look for a definition of `choices` in `RoadTrip` before falling back to `Oracle` if it does not find `choices` defined in `RoadTrip`. To see this in action, change the name of the `choices` method in `RoadTrip` (call it `chooses`) and see what happens.

---

###### Question 3

How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

What is the lookup chain for `Orange` and `HotSauce`?



**My Response:**  

You can find where Ruby will look for a method when that method is called by checking the 'method look up path', and you can do that by calling the `ancestors` method on the class name of the particular object, which is also how you find the object's ancestors.

```ruby
Orange.ancestors 			# => [Orange, Taste, Object, Kernel, BasicObject]
HotSauce.ancestors 		# => [HotSauce, Taste, Object, Kernel, BasicObject]
```

In the above example you can see the lookup chain for both `Orange` and `HotSauce`.

---

###### Question 4  

What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end
  
  def type
    @type
  end
  
  def type=(t)
    @type = type
  end
  
  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

**My Response:**  

We could an an access modifier, `attr_accessor`, and remove the getter and setter methods defined within the class.

```ruby
class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

**Launch School's Response:**  

Launch School's response agrees with what is above, but they argue there is still something that can be improved.  

Currently, inside the `describe_type` method, we are referencing the `@type` variable with the `@` symbol, but this is not needed. As there is a method in the class which replaces the need to access the instance variable directly we can change the `describe_type` method to be:

```ruby
def describe_type
  puts "I am a #{type} type of Bees Wax"
end
```

This is much cleaner, and it is standard practice to refer to instance variables inside the class without `@` if the getter method is available.

---

###### Question 5  

There are a number of variables listed below. What are the different types and how do you know which is which?  

```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

**My Response:**  

The first one is an example of a local variable, as it is initialized without any special symbol prepending the variable name. The second one is an intance variable, as the variable name begins with a single `@` sign. The third is a class variable, evident from the `@@` that prepends the variable name.

---

###### Question 6  

If I have the following class:

```ruby
class Television
  def self.manufacturer
    # method logic
  end
  
  def model
    # method logic
  end
end
```

Which one of these is a class method (if any) and how do you know? How would you call a class method?  



**My Response:**  

The `self.manufactuer` method is a class method since it is prefixed with the keyword `self`. To call this class method, you must call it on the class itself; thus, `Television.manufacturer`.

---

###### Question 7  

If we have a class such as the one below:

```ruby
class Cat
  @@cats_count = 0
  
  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end
  
  def self.cats_count
    @@cats_count
  end
end
```

Explain what the `@@cats_count` variable does and how it works. What code would you need to write to test your theory?



**My Response:**  

The `@@cats_count` variable is a class variable that increments by one every time a new `Cat` object is created, or instantiated. In order to test the theory we should define the `Cat` class and then call the `cats_count` class method on the `Cat` class to check the value of the `@@cats_count` class variable. Then we could instantiate a new `Cat` object and then check the value of the `@@cats_count` class variable again to see if it did indeed increment by one.

```ruby
class Cat
  @@cats_count = 0
  
  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end
  
  def self.cats_count
    @@cats_count
  end
end

>> Cat.cats_count 	# => 0 is expected
>> kitty = Cat.new("tabby")
>> Cat.cats_count 	# => 1 is expected
```

---

###### Question 8  

If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end
```

And another class:

```ruby
class Bingo
  def rules_of_play
    # rules of play
  end
end
```

What can we add to the `Bingo` class to allow it to inherit the `play` method from the `Game` class?  



**My Response:**  

In order that Bingo can inherit the `play` method we need to add the following to our `Bingo` class definition, right after the word `Bingo`: `< Game`.

```ruby
class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

---

###### Question 9  

If we have the class:

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.  



**My Response:**

If we added a `play` method to the `Bingo` class, then any `Bingo` object on which the `play` method was called would use the `play` method defined within the `Bingo` class.

---

###### Question 10  

What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can. 



**My Response:**

* Allows for greater organization of one's code.
* Allows one to keep certain functionality reserved for certain objects.

**Launch School's Response:**  

Because there are so many benefits to using OOP we will just summarize some of the major ones:

1. Creating objects allows programmers to think more abstractly about the code they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an application without duplication.
5. We can build applications faster as we can reuse pre-written code.
6. As the software becomes more complex this complexity can be more easily managed.

---

