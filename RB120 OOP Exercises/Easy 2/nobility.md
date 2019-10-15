### Nobility

---

Now that we have a `Walkable` module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.



We need a new class `Noble` that shows the title and name when `walk` is called:

```ruby
byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
```

We must have access to both `name` and `title` because they are needed for other purposes that we aren't showing here.

```ruby
byron.name
=> "Byron"
byron.title
=> "Lord"
```

---

**My Code:**

```ruby
module Walkable
  def walk
  	puts "#{title} #{name} #{gait} forward"
  end
end

class Noble
  attr_reader :name, :title
  
  include Walkable
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def gait
    "struts"
  end
end
```

---

**Launch School's Solution:**  

The easiest way to accomplish this is to provide a method that returns both the title and name objects of the `Noble` class, and just the name for other classes.

```ruby
module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private
  
  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private
  
  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private
  
  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title
  
  include Walkable
  
  def initialize(name, title)
    @title = title
    @name = name
  end
  
  def to_s
    "#{title} #{name}"
  end
  
  private
  
  def gait
    "struts"
  end
end
```

---

**Further Exploration:**  

This exercise can be solved in a similar manner by using inheritance; a Noble is a Person, and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need to make to this program to establish these relationships and eliminate the two duplicated `#to_s` method?



Is `to_s` the best way to provide the name and title functionality we needed for this exercise? Might it be better to create either a different `name` method (or say a new `full_name` method) that automatically accesses `@title` and `@name`? There are tradeoffs with each choice -- they are worth considering.

---

**My Code:**  

Using the `to_s` method to provide the name and title functionality.

```ruby
module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private
  
  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def to_s
    "#{title} #{name}"
  end
  
  private
  
  def gait
		"struts"
  end
end

class Cat
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end
  
  private
  
  def gait
    "saunters"
  end
end

class Cheetah < Cat
  
  private
  
  def gait
    "runs"
  end
end
```

Using a `full_name` variable:

```ruby
module Walkable
  def walk
    "#{full_name} #{gait} forward"
  end
end

class Person
  attr_reader :full_name
  
  include Walkable
  
  def initialize(full_name)
    @full_name = full_name
  end
    
  private
  
  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :full_name, :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
    @full_name = "#{title} #{name}"
  end
  
  private
  
  def gait
		"struts"
  end
end

class Cat
  attr_reader :full_name
  
  include Walkable
  
  def initialize(full_name)
    @full_name = full_name
  end
  
  private
  
  def gait
    "saunters"
  end
end

class Cheetah < Cat
  
  private
  
  def gait
    "runs"
  end
end
```



