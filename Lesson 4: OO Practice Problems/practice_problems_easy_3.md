## Practice Problems: Easy 3

###### Question 1  

If we have this code:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

What happens in each of the following cases:  

case 1:

```ruby
hello = Hello.new
hello.hi
```

case 2:

```ruby
hello = Hello.new
hello.bye
```

case 3:

```ruby
hello = Hello.new
hello.greet
```

case 4:

```ruby
hello = Hello.new
hello.greet("Goodbye")
```

case 5:

```ruby
Hello.hi
```

**My Response:**  

case 1:

```ruby
Hello				# printed output
=> nil			# return value
```

case 2:

```ruby
NoMethodError: undefined method `bye' for #<Hello:0x00007f8a610ab408>
```

Prints an error message because there is no `bye` method in either the `Hello` class or the `Greeting` class.  

case 3:

```ruby
ArgumentError: wrong number of arguments (given 0, expected 1)
```

Prints out some error message since the `greet` message is called without being passed an argument.  

case 4:

```ruby
Goodbye			# printed output
=> nil			# return value
```

case 5:

```ruby
NoMethodError: undefined method `hi' for Hello:Class
```

An error message will be printed as the `hi` method is defined as an instance method, not a class method. Therefore calling `hi` on the `Hello` class will raise an exception.

---

###### Question 2  

In the last question we had the following classes:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

If we call `Hello.hi` we get an error message. How would you fix this?  

**My Response:**  

If we do want to be able to call the `hi` method on the `Hello` class then we will need to define a class method. We could either convert the current `hi` instance method to a `hi` class method or create a brand new `hi` class method in addition to the `hi` instance method. In either case, `hi` must be prefixed with `self.` in the method definition for the class method.  

We will also have to define a `greet` class method. Again, we can either change the `greet` instance method in the `Greeting` class to a class method or define an additional method, specified to work on the class.

```ruby
class Greeting
  def greet(message)
    puts message
  end
  
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
  def self.hi
    greet("Hello")
  end
end
```

**Launch School's Response:**  

You could define the `hi` method on the `Hello` class as follows:  

```ruby
class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end
```

This is rather cumbersome. Note that we cannot simply call `greet` in the `self.hi` method definition because the `Greeting` class itself only defines `greet` on its instances, rather than on the `Greeting` class itself.

---

###### Question 3  

When objects are created they are a separate realization of a particular class.  

Given the class below, how do we create two different instances of this class, both with separate names and ages?

```ruby
class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end
  
  def age
    puts @age
  end
  
  def name
    puts @name
  end
  
  def hiss
    puts "Hisssss!!!"
  end
end
```

**My Response:**  

1st instance:

```ruby
angry_cat1 = AngryCat.new(5, "Garfield")
```

2nd instance:

```ruby
angry_cat2 = AngryCat.new(7, "Grumps")
```

---

###### Question 4  

Given the class below, if we created a new instance of the class and then called `to_s` on that instance we would get something like `"#<Cat:0x007ff39b356d30>"`.

```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (this is assuming that `"tabby"` is the `type` we passed in during initialization).  

**My Response:**  

We could redefine the `to_s` method for our `Cat` class.

```ruby
class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type} cat."
  end
end
```

or...

```ruby
class Cat
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{type} cat"
  end
end
```

---

###### Question 5  

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

What would happen if I called the methods like shown below?

```ruby
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```

**My Response:**  

Calling the `manufacturer` method on `tv`, an instance of the `Television` class, would raise an exception because the `manufacturer` method is a class method, not an instance method. However, the `model` method is an instance method and should thus perform the function that is defined to do when called on `tv`. On the other hand, when the `manufacturer` class method is called on the `Television` class it should perform the function that it was defined to do since it is a class method being called on the class within which it was defined. But, the `model` instance method will raise an exception when called on the `Television` class because it is not a class method.

---

###### Question 6  

If we have a class such as the one below:

```ruby
class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    @age += 1
  end
end
```

In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix?  

**My Response:**  

We could write it with age prefixed with `@` rather than `self`.

```ruby
def make_one_year_older
  @age += 1
end
```

---

###### Question 7  

What is used in this class but doesn't add any value?  

```ruby
class Light
  attr_accessor :brightness, :color
  
  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end
  
  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
  
end
```

**My Response:**  

I'm not particularly sure. 

**Launch School's Response:**  

The answer here is the `return` in the `information` method. Ruby automatically returns the result of the last line of any method, so adding `return` to this line in the method does not add any value and so therefore should be avoided. We also never use the `attr_accessor` for brightness and color. Though, these methods do add potential value, as they give us the option to alter brightness and color outside the `Light` class.



