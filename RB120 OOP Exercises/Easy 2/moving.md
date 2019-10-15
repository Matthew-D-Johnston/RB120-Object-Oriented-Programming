### Moving

---

**Problem:**  

You have the following classes:

```ruby
class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "runs"
  end
end
```

You need to modify the code so that this works:

```ruby
mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
```

You are only allowed to write one new method to do this.

---

**My response:**  

Need to include a `Walkable` module with a `walk` method in each class.

```ruby
module Walkable
  def walk
  	puts "#{@name} #{gait} forward"
  end
end

class Person
  attr_reader :name
  
  include Walkable
  
  ...
    
end

class Cat
  attr_reader :name
  
  include Walkable
  
  ...
    
end

class Cheetah
  attr_reader :name
  
  include Walkable
  
  ...
    
end  
```

