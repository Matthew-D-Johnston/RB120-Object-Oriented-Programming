# whats_the_output.rb

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# puts '-------'

# Revised Code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s                    # removed `to_s`
  end

  def to_s
                                    # removed `@name.upcase!`
    "My name is #{@name.upcase}."   # appended `@name` with `.upcase`
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

puts '------'

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

puts '-----'

# Understanding the `to_s` in the `initialize` method definition:

class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name.class
  end
  
  def class
    "My class is..."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy.class

