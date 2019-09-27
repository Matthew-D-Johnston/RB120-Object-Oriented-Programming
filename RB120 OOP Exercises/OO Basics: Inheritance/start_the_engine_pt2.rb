# start_the_engine_pt2.rb

# Given the following code, modify `#start_engine` in `Truck` by appending
# `Drive fast, please!` to the return value of `#start_engine` in `Vehicle`.
# The `'fast'` in `'Drive fast, please!'` should be the value of `speed`.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super + " Drive #{speed}, please!"
  end
end

# truck1 = Truck.new
# puts truck1.start_engine('fast')  # error returned because super is being
                                  # passed `speed`, but the `start_engine`
                                  # method in the `Vehicle` class does not take
                                  # an argument.

# Launch School's solution:

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!" # the () after `super` solves the
  end                                    # problem as empty parentheses mean
end                                      # that no arguments will be passed.

truck1 = Truck.new
puts truck1.start_engine('fast')

