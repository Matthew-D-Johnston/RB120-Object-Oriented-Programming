# fix_the_program_drivable.rb

module Drivable
  def drive       # changed self.drive to drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
