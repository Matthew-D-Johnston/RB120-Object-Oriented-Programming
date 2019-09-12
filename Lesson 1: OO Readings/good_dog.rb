# good_dog.rb

# class GoodDog
#   attr_accessor :name
  
#   def initialize(name)
#     @name = name
#   end
  
#   def speak
#     "#{@name} says arf!"
#   end

#   def self.what_am_i            # Class method definition
#     "I'm a GoodDog class!"
#   end
# end

# puts GoodDog.what_am_i

class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs   # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs   # => 2
