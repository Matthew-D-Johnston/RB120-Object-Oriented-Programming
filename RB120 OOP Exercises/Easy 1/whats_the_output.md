### What's the Output?

---

Take a look at the following code:

```ruby
class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name.to_s
  end
  
  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

Which gives the following output...

```ruby
puts fluffy.name 			# => Fluffy
puts fluffy						# => My name is FLUFFY.
puts fluffy.name 			# => FLUFFY
puts name							# => FLUFFY
```

---

My response:



The first thing to notice is that it appears the `to_s` method call within the `initialize` method definition is not doing anything consequential since if we remove it we get the exact same output. Also, it's not clear that we would want the `@name` instance variable to be assigned to the return value of `name.to_s` anyways since the `to_s` method definition includes the `@name` variable, which is precisely the one we are trying to initialize and assign a value to. This seems like it would lead into some kind of weird recursion if we actually tried to attempt it, and I don't think that is the intention of the code.



I think that the intention of the code is merely to redefine the `to_s` method for the `Pet` class so that when `puts` is invoked on an object or instantiation of the `Pet` class it prints out a friendly message (i.e. `My name is ...`).



Thus, we can remove the `to_s` method call within the `initialize` method definition. Also, it's not clear that we want to permanently convert all of the characters of the `@name` instance variable to their uppercase version. We only want to make the conversion for whenever the `to_s` method is invoked. If we did want to permanently convert the characters then it might be best to create a separate method that specifies that this is what we are doing and intended to do. Just sticking the `upcase!` method with the `!` bang operator appended on the end into the `to_s` method definition looks like a random decision. So, we shall remove that line of code a shift the `upcase` method, without the `!` to the next line where we call it within the string interpolation: `"My name is #{@name.upcase}."`.



So...

```ruby
class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name					# => Fluffy
puts fluffy								# => My name is FLUFFY.
puts fluffy.name					# => Fluffy
puts name									# => Fluffy
```

---

**Launch School's Solution:**

```ruby
class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name.to_s
  end
  
  def to_s
    "My name is #{@name.upcase}."
  end
end
```

###### Discussion

The original version of `#to_s` uses `String#upcase!` which mutates its argument in place. This causes `@name` to be modified, which in turn causes `name` to be modified: this is because `@name` and `name` reference the same object in memory.



Oh, and that `to_s` inside the `initialize` method? We need that for the challenge under Further Exploration...(I was wondering about that).

---

**Further Exploration:**

What would happen in this case?

```ruby
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

Well, with my code (i.e. without the `to_s` method call within the `initialize` method definition), I get the following output...

```ruby
puts fluffy.name				# => 42
puts fluffy							# => NoMethodError: undefined method `upcase' for 42:Integer
puts fluffy.name				
puts name								
```

Thus, when the `puts` method call on `fluffy` invokes the `to_s` method, the `upcase` method is invoked on the integer `42`, but being an Integer object for which the `upcase` method is not defined, we get a `NoMethodError`.



But with the `to_s` method call in the `initialize` method definition...

```ruby
puts fluffy.name				# => 42
puts fluffy							# => My name is 42.
puts fluffy.name				# => 42	
puts name								# => 43
```

This is what we expected.



However, I still am not sure why the `to_s` method within the `initialize` method definition doesn't run into problems becomes it is trying to initialize the `@name` instance variable at the same time that our definition of the `to_s` method definition includes it within the string interpolation. As mentioned above, it would appear that some kind of weird recursion would occur. Or, perhaps since `initialize` is a special constructor method, it is invoking the `to_s` method that is included as a part of the `Object` superclass.



I just ran an experiment and I think my last thought there is correct. I took another method from the `Object` superclass, namely `class`, and wrote a similar code to what is above but replaced `to_s` with `class` as below...

```ruby
class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name.class
  end
  
  def class
    "My class is..."
  end
end
  
name = "Fluffy"
fluffy = Pet.new(name)
puts fluffy.name 						# => String
puts fluffy.class						# => My class is...
```

As we can see, despite having defined a unique `class` method for the `Pet` class, the `class` method call within the `initialize` method definition does not use this uniquely defined `class` method but invokes the `class` method defined within the `Object` superclass.







