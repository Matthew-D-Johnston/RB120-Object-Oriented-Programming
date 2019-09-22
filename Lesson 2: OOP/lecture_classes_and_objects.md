## Lecture: Classes and Objects

1. Given the below usage of the `Person` class, code the class definition.

```ruby
bob = Person.new('bob')
bob.name									# => 'bob'
bob.name = 'Robert'
bob.name									# => 'Robert'
```

My code:

```ruby
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = (name)
  end
end
```

Launch School's solution was similar.

---

2. Modify the class definition from above to facilitate the following methods. Note that there is no `name=` setter method now.

```ruby
bob = Person.new('Robert')
bob.name 									# => 'Robert'
bob.first_name						# => 'Robert'
bob.last_name 						# => ''
bob.last_name = 'Smith'
bob.name 									# => 'Robert Smith'
```

Hint: let `first_name` and `last_name` be "states" and create an instance method called `name` that uses those states.



My code:

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name='', last_name='')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    "#{@first_name} #{@last_name}".strip
  end
end
```

Launch School's solution:

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
end
```

---

3. Now create a smart `name=` method that can take just a first name or a full name, and knows how to set the `first_name` and `last_name` appropriately.

```ruby
bob = Person.new('Robert')
bob.name 									# => 'Robert'
bob.first_name 						# => 'Robert'
bob.last_name 						# => ''
bob.last_name = 'Smith'
bob.name 									# => 'Robert Smith'

bob.name = "John Adams"
bob.first_name 						# => 'John'
bob.last_name 						# => 'Adams'
```

My code:

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
  
  def name
    "#{@first_name} #{@last_name}".strip
  end
  
  def name=full_name
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
    "#{first_name} #{last_name}".strip
  end
end
```

Launch School's solution:

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end
```

Note the redundant code in the `initialize` and the `name=` methods. Let's move that to another method to DRY up the code. Our new method can be private, since it's not being used outside of the class definition.

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parse_full_name(full_name)
  end
  
  private
  
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end
```

---

4. Using the class definition from step #3, let's create a few more people--that is, `Person` objects.

```Ruby
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
```

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?



My code:

```ruby
bob.name == rob.name
```



Launch School's solution:



We would not be able to do `bob == rob` because that compares whether the two `Person` objects are the same, and right now there's now way to do that. We have to be more precise and compare strings:

```ruby
bob.name == rob.name
```

The above code compares a string with a string. But aren't strings also just objects of `String` class? If we can't compare two `Person` objects with each other with `==`, why can we compare two different `String` objects with `==`?

```ruby
str1 = 'hello world'
str2 = 'hello world'

str1 == str2 				# => true
```

What about arrays, hashes, integers? It seems like Ruby treats some core library objects differently. For now, memorize this behaviour. We'll explain the underpinning reason in a future lesson.

---

5. Continuing with our `Person` class definition, what does the below print out?

```ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
```



My response:

```ruby
# => "The person's name is: #<Person:0x00007f93b41a4d30 @first_name='Robert', @last_name='Smith'"
```

After running the code, I'll revise my response to:

```ruby
# => The person's name is: #<Person:0x00007f93b41a4d30
```



Launch School's response:

```
The person's name is: #<Person:0x007fb873252640>
```

This is because when we use string interpolation (as opposed to string concatenation), Ruby automatically calls the `to_s` instance method on the expression between the `#{}`. Every object in Ruby comes with a `to_s` inherited from the `Object` class. By default, it prints out some gibberish, which represents its place in memory.



If we don not have a `to_s` method that we can use, we must construct the string in some other way. For instance, we can use:

```ruby
puts "The person's name is: " + bob.name 	# => The person's name is: Robert Smith
```

or

```ruby
puts "The person's name is: #{bob.name}"	# => The person's name is: Robert Smith
```

Let's add a `to_s` method to the class:

```ruby
class Person
  # ... rest of class omitted for brevity
  
  def to_s
    name
  end
end
```

Now, what does the below output?

```ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
```



My response:

```ruby
# => The person's name is: Robert Smith
```



Launch School's response:  

This time it work's as expected, due to the `to_s` method!

```
The person's name is: Robert Smith
```





