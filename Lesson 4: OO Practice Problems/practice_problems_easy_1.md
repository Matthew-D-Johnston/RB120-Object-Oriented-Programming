## Practice Problems: Easy 1

###### Question 1  

Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?  

1. `true`
2. `"hello"`
3. `[1, 2, 3, "happy days"]`
4. `142`

**My Response:**  

1. This is an object of the `TrueClass` class.
2. This is an object of the `String` class.
3. This is an object of the `Array` class.
4. This is an object of the `Integer` class.

One can find out what class they belong to by invoking the `class` method.

---

###### Question 2  

If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast` using the module `Speed`? How can you check if your `Car` or `Truck` can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

**My Response:**  

We can add the ability for the `Car` and `Truck` classes to `go_fast` by "mixing in" the module `Speed` using the `include` key word. 

```ruby
class Car
  include Speed
  
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

One can check to see if `Car` or `Truck` can now go fast by creating a new `Car` or `Truck` object and calling the `go_fast` instance method from the `Speed` module on the newly created object.

```ruby
Car.new.go_fast => "I am a Car and going super fast!"
Truck.new.go_fast => "I am a Truck and going super fast!"
```

---

###### Question 3  

In the last question we had a module called `Speed` which contained a `go_fast` method. We included this module in the `Car` class as shown below.

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the `go_fast` method from an instance of the `Car` class (as shown below) you might have noticed that the `string` printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```ruby
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```

**My Response:**  

We are able to print the name of the type of vehicle by way of string interpolation in the `go_fast` method that we defined in the `Speed` module. Since the `go_fast` method is an instance method, we call it on a object and the `self` in the string interpolation part (i.e. `#{self.class}`) of the string refers to the object upon which we are calling the method. Since there is a `class` method call on `self`, the return value for `self.class` will be the class that the object belongs to, which in this case, is the name of the type of vehicle, or `Car`. `Car` will thus be printed with the rest of the string according to the rules of string interpolation.  

**Launch School's Response:**  

We use `self.class` in the method and this works the following way:  

1. `self` refers to the object itself, in this case either a `Car` or `Truck` object.  
2. We ask `self` to tell us its class with `.class`. It tells us.
3. We don't need to use `to_s` here because it is inside of a `string` and is interpolated which means it will take care of the `to_s` for us.

---

###### Question 4  

If we have a class `AngryCat` how do we create a new instance of this class?  

The `AngryCat` class might look something like this:

```ruby
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
```

**My Response:**  

We create a new instance by creating an object, either with or without assigning the new object to a variable.

```ruby
angry_cat = AngryCat.new 	# variable assignment
AngryCat.new 							# without variable assignment
```

---

###### Question 5  

Which of these two classes has an instance variable and how do you know?  

```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

I want to say both have an instance variable, although I think that only the `Pizza` class definition has properly defined its constructor method `initialize` with the `@` sign in front of the `name` variable. A single `@` sign signals that the variable is an instance variable.  

**Launch School's Response:**  

You can find out if an object has instance variables by either looking at the class or asking the object. First, let's look at the class definitions.  



You might have noticed in the `Pizza` class there is a variable where the variable name starts with an `@` symbol. This means that this class has an instance variable.



But let us be triple sure that only `Pizza` has an instance variable by asking our objects if they have variables.



To do this we first need to create a `Pizza` object and a `Fruit` object.

```ruby
hot_pizza = Pizza.new("cheese")
orange = Fruit.new("apple")
```

Now we can ask each of these objects if they have instance variables.

```ruby
>> hot_pizza.instance_variables
=> [:@name]
>> orange.instance_variables
=> []
```

As you can see, if we call the `instance_variables` method on the instance of the class we will be informed if the object has any instance variables and what they are.



By doing this we have found out that `Pizza` has instance variables while `Fruit` does not.

---

###### Question 6  

What could we add to the class below to access the instance variable `@volume`?

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

**My Response:**  

We could add an access modifier, such as `attr_reader :volume`, which would create a getter method for the instance variable `@volume`.

```ruby
class Cube
  attr_reader :volume
  
  def initialize(volume)
    @volume = volume
  end
end
```

**Launch School's Response:**  

Technically we don't need to add anything at all. We are able to access instance variables directly from the object by calling `instance_variable_get` on the instance. This would return something like this:

```ruby
>> big_cube = Cube.new(5000)
>> big_cube.instance_variable_get("@volume")
=> 5000
```

While this works it is generally not a good idea to access instance variables in this way. Instead we can add a method to this object that returns the instance variable.



An example of this would be adding a method called `get_volume`:

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
  
  def get_volume
    @volume
  end
end
```

Now if we call `get_volume` on our `big_cube` we will get:

```ruby
>> big_cube.get_volume
=> 5000
```

---

###### Question 7  

What is the default return value of `to_s` when invoked on an object? Where could you go to find out if you want to be sure?  



**My Response:**  

I didn't know so I went to the Ruby documentation for the `Object` class ([here](https://ruby-doc.org/core-2.6.3/Object.html#method-i-to_s)). The entry for the `to_s` method says, "Returns a string representing _obj_. The default `to_s` prints the object's class and an encoding of the object id. As a special case, the top-level object that is the initial execution context of Ruby programs 'main'." 

---

###### Question 8  

If we have a class such as the one below:  

```ruby
class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    self.age += 1
  end
end
```

You can see in the `make_one_year_older` method we have used `self`. What does `self` refer to here?



**My Response:**  

`self` refers to the object on which the `make_one_year_older` method is called (i.e. the calling object).

---

###### Question 9  

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

In the name of the `cats_count` method we have used `self`. What does `self` refer to in this context?  



**My Response:**  

In this context, `self` refers to the class within which the `cats_count` method is defined (i.e. it is a class method). Therefore it refers to the `Cat` class.

---

###### Question 10  

If we have the class below, what would you need to call to create a new instance of this class.

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

**My Response:**  

We would need to call the `new` method on the `Bag` class with two arguments specified, one for the `color` parameter and one for the `material` parameter. Thus, something like this, `Bag.new('blue', 'plastic')`.





