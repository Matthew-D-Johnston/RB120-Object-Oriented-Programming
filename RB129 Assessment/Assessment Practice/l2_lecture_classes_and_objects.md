##### RB120 Object Oriented Programming > Lesson 2: Object Oriented Programming

---

## Lecture: Classes and Objects

1. Given the below usage of the `Person` class, code the class definition.

```ruby
bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
```

My solution:

```ruby
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end
```

---

2. Modify the class definition from above to facilitate the following methods. Note that there is no `name=` setter method now.  

```ruby
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'
```

My solution:

```ruby
class Person
  attr_reader :name
  
  def initialize(name)
		@name = name
  end
  
  def first_name
    name.split.first
  end
  
  def first_name=(n)
    @name = "#{n} #{self.last_name}"
  end
  
  def last_name
    name.split.size == 1 ? '' : name.split.last
  end
  
  def last_name=(n)
    @name = "#{self.first_name} #{n}"
  end
end
```

Or...

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name='', last_name = '')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    last_name == '' ? first_name : "#{first_name} #{last_name}"
  end
end
```

Or, after refactoring a bit...

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name='', last_name='')
    @first_name = first_name
    @last_name = last_name
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
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
```

My solution:

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name='', last_name='')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    @first_name = full_name.split.first
    full_name.split.size == 1 ? @last_name = '' : @last_name = full_name.split.last
  end
end
```

---

4. Using the class definition from step #3, let's create a few more people -- that is, `Person` objects.

```ruby
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
```

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?  

```ruby
bob.name == rob.name
```

---

5. Continuing with our `Person` class definition, what does the below print out?

```ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
```

Output:

```
The person's name is: #<Person:0x00007fa9bf96ee78>
```

However,

```ruby
puts "The person's name is: #{bob.name}"
```

ouputs the following:

```
The person's name is: Robert Smith
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

Output:

```
The person's name is: Robert Smith
```

