# nobility.rb

# module Walkable
#   def walk
#     "#{title} #{name} #{gait} forward"
#   end
# end

# class Noble
#   attr_reader :name, :title
  
#   include Walkable
  
#   def initialize(name, title)
#     @name = name
#     @title = title
#   end

#   private
  
#   def gait
#     "struts"
#   end
# end

# byron = Noble.new("Byron", "Lord")
# p byron.walk

# p byron.name
# p byron.title

puts '------'

# Launch School Solution:

# module Walkable
#   def walk
#     "#{self} #{gait} forward"
#   end
# end

# class Person
#   attr_reader :name
  
#   include Walkable
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
  
#   private
  
#   def gait
#     "strolls"
#   end
# end

# class Cat
#   attr_reader :name
  
#   include Walkable
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
  
#   private
  
#   def gait
#     "saunters"
#   end
# end

# class Cheetah
#   attr_reader :name
  
#   include Walkable
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
  
#   private
  
#   def gait
#     "runs"
#   end
# end

# class Noble
#   attr_reader :name, :title
  
#   include Walkable
  
#   def initialize(name, title)
#     @title = title
#     @name = name
#   end
  
#   def to_s
#     "#{title} #{name}"
#   end
  
#   private
  
#   def gait
#     "struts"
#   end
# end

# byron = Noble.new("Byron", "Lord")
# p byron.walk

# mike = Person.new("Mike")
# p mike.walk

# p byron.name
# p byron.title


puts '-----'

# Further Exploration:

# module Walkable
#   def walk
#     "#{self} #{gait} forward"
#   end
# end

# class Person
#   attr_reader :name
  
#   include Walkable
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
  
#   private
  
#   def gait
#     "strolls"
#   end
# end

# class Noble < Person
#   attr_reader :name, :title
  
#   def initialize(name, title)
#     @name = name
#     @title = title
#   end
  
#   def to_s
#     "#{title} #{name}"
#   end
  
#   private
  
#   def gait
#     "struts"
#   end
# end

# class Cat
#   attr_reader :name
  
#   include Walkable
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
  
#   private
  
#   def gait
#     "saunters"
#   end
# end

# class Cheetah < Cat
  
#   private
  
#   def gait
#     "runs"
#   end
# end

# byron = Noble.new("Byron", "Lord")
# mike = Person.new("Mike")
# kitty = Cat.new("Kitty")
# flash = Cheetah.new("Flash")
# p byron.walk
# p mike.walk
# p kitty.walk
# p flash.walk

puts '-----'

# FE 2:

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

byron = Noble.new("Byron", "Lord")
mike = Person.new("Mike")
kitty = Cat.new("Kitty")
flash = Cheetah.new("Flash")
p byron.walk
p mike.walk
p kitty.walk
p flash.walk
