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


class MyCar
  attr_accessor :color  # additional code for being able to change and view the color
  attr_reader :year     # additional code for viewing, but not modifying, the year
  attr_reader :model
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
  
  def spray_paint(paint_color)
    @color = paint_color
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    puts "My car is a #{color} #{year} #{model}"
  end
end

MyCar.gas_mileage(13, 351)

my_car = MyCar.new(2000, "Toyota Camry", "red")
my_car.to_s

# car = MyCar.new(2000, "Toyota Camry", 'black')
# car.color # => 'black'
# car.spray_paint('white')
# car.color # => 'white'