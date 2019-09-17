# my_car.rb

class Vehicle
  attr_accessor :color  # additional code for being able to change and view the color
  attr_reader :year     # additional code for viewing, but not modifying, the year
  attr_reader :model    # same as for the year
  
  @@number_of_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def self.total_number_of_vehicles
    @@number_of_vehicles
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

  # def age
  #   "This vehicle is #{calculate_age} years old."
  # end
    
  # private
  
  # def calculate_age
  #   Time.new.year - year
  # end
  def age
    "Your #{model} is #{years_old} years old."
  end
  
  private
  
  def years_old
    Time.now.year - year
  end
end

module Haulerable
  def haul
    "I'm hauling something"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    puts "My car is a #{color} #{year} #{model}"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  include Haulerable
  
  def to_s
    puts "My truck is a #{color} #{year} #{model}"
  end
end

car = MyCar.new(2000, "Toyota Yaris", 'white')
truck = MyTruck.new(2005, "GMC Sierra", 'black')
car.to_s
truck.to_s

p Vehicle.total_number_of_vehicles
p truck.haul

puts MyCar.ancestors
puts "------"
puts MyTruck.ancestors
puts "------"
puts Vehicle.ancestors

car.current_speed
car.speed_up(20)
car.current_speed
car.brake(20)
car.current_speed
car.shut_down
truck.current_speed
truck.speed_up(30)

p truck.age
p car.age


