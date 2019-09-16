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

# class GoodDog
#   @@number_of_dogs = 0

#   def initialize
#     @@number_of_dogs += 1
#   end

#   def self.total_number_of_dogs
#     @@number_of_dogs
#   end
# end

# puts GoodDog.total_number_of_dogs   # => 0

# dog1 = GoodDog.new
# dog2 = GoodDog.new

# puts GoodDog.total_number_of_dogs   # => 2

# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   def initialize(n, a)
#     self.name = n
#     self.age = a * DOG_YEARS
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# puts sparky.age           # => 28

# puts sparky
# p sparky

# puts "------"

# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   def initialize(n, a)
#     self.name = n
#     self.age = a * DOG_YEARS
#   end

#   def to_s
#     "This dog's name is #{name} and it is #{age} in dog years."
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# puts sparky.age           # => 28

# puts sparky
# p sparky
# puts sparky.inspect

# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{self.name} weighs #{self.weight} and is #{self.height} tall."
#   end

#   def what_is_self
#     self
#   end
# end

# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# p sparky.what_is_self


# class MyCar
#   attr_accessor :color  # additional code for being able to change and view the color
#   attr_reader :year     # additional code for viewing, but not modifying, the year
#   attr_reader :model
  
#   def initialize(year, model, color)
#     @year = year
#     @model = model
#     @color = color
#     @current_speed = 0
#   end
  
#   def speed_up(number)
#     @current_speed += number
#     puts "You push the gas and accelerate #{number} mph."
#   end
  
#   def brake(number)
#     @current_speed -= number
#     puts "You push the brake and decelerate #{number} mph."
#   end
  
#   def current_speed
#     puts "You are now going #{@current_speed} mph."
#   end
  
#   def shut_down
#     @current_speed = 0
#     puts "Let's park this bad boy!"
#   end
  
#   def spray_paint(paint_color)
#     @color = paint_color
#   end
  
#   def self.gas_mileage(gallons, miles)
#     puts "#{miles / gallons} miles per gallon of gas"
#   end

#   def to_s
#     puts "My car is a #{color} #{year} #{model}"
#   end
# end

# MyCar.gas_mileage(13, 351)

# my_car = MyCar.new(2000, "Toyota Camry", "red")
# my_car.to_s

# car = MyCar.new(2000, "Toyota Camry", 'black')
# car.color # => 'black'
# car.spray_paint('white')
# car.color # => 'white'

# class Animal
#   def speak
#     "Hello!"
#   end
# end

# class GoodDog < Animal
# end

# class Cat < Animal
# end

# sparky = GoodDog.new
# paws = Cat.new
# puts sparky.speak         # => Hello!
# puts paws.speak           # => Hello!

# class Animal
#   def speak
#     "Hello!"
#   end
# end

# class GoodDog < Animal
#   attr_accessor :name

#   def initialize(n)
#     self.name = n
#   end

#   def speak
#     "#{self.name} says arf!"
#   end
# end

# class Cat < Animal
# end

# sparky = GoodDog.new("Sparky")
# paws = Cat.new

# puts sparky.speak           # => Sparky says arf!
# puts paws.speak             # => Hello!

# class Animal
#   def speak
#     "Hello!"
#   end
# end

# class GoodDog < Animal
#   def speak
#     super + " from GoodDog class"
#   end
# end

# sparky = GoodDog.new
# puts sparky.speak        # => "Hello! from GoodDog class"

# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# class GoodDog < Animal
#   def initialize(color)
#     super
#     @color = color
#   end
# end

# bruno = GoodDog.new("brown")

# p bruno

# class BadDog < Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# p BadDog.new(2, "bear")

# module Swimmable
#   def swim
#     "I'm swimming!"
#   end
# end

# class Animal; end

# class Fish < Animal
#   include Swimmable       # mixing in Swimmable module
# end

# class Mammal < Animal
# end

# class Cat < Mammal
# end

# class Dog < Mammal
#   include Swimmable       # mixing in Swimmable module
# end

# sparky = Dog.new
# neemo = Fish.new
# paws = Cat.new

# puts sparky.swim
# puts neemo.swim
# puts paws.swim

# module Walkable
#   def walk
#     "I'm walking."
#   end
# end

# module Swimmable
#   def swim
#     "I'm swimming."
#   end
# end

# module Climbable
#   def climb
#     "I'm climbing."
#   end
# end

# class Animal
#   include Walkable

#   def speak
#     "I'm an animal, and I speak!"
#   end
# end

# puts "---Animal method lookup---"
# puts Animal.ancestors

# fido = Animal.new
# p fido.speak
# p fido.walk
# p fido.swim


# class GoodDog < Animal
#   include Swimmable
#   include Climbable
# end

# puts "---GoodDog method lookup---"
# puts GoodDog.ancestors

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_out_of_place_method(num)
    num ** 2
  end
end

buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')
kitty.say_name('kitty')

p value = Mammal.some_out_of_place_method(4)
p value = Mammal::some_out_of_place_method(4)
