## Practice Problems: Hard 1

###### Question 1  

Alyssa has been assigned a task of modifying a class that was initially created to keep track of secret information. The new requirement calls for adding logging, when clients of the class attempt to access the secret data. Here is the class in its current form:

```ruby
class SecretFile
  attr_reader :data
  
  def initialize(secret_data)
    @data = secret_data
  end
end
```

She needs to modify it so that any access to `data` must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. The logging class has been supplied to Alyssa and looks like the following:

```ruby
class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
```

Hint: Assume that you can modify the `initialize` method in `SecretFile` to have an instance of `SecurityLogger` be passed in as an additional argument. It may be helpful to review the lecture on collaborator objects for this practice problem.  

**My Response:**  

Based on the hint, we could do something like the following to the `initialize` method in the `SecretFile` class:

```ruby
class SecretFile
  attr_reader :data
  
  def initialize(secret_data, log)
    @data = secret_data
    @log = log.create_log_entry
  end
end
```

**Launch School's Response:**  

First modify the `initialize` method to take a `SecurityLogger` object as an argument and assign it to another instnace variable.

```ruby
class SecretFile
  attr_reader :data
  
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end
end
```

Second, Alyssa needs to remove the `attr_reader` and replace it with an explicit implementation of a method that returns the `data` instance variable. In that new method, she can add a call to the security logger.  

```ruby
class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end
  
  def data
    @logger.create_log_entry
    @data
  end
end
```

---

###### Question 2  

Ben and Alyssa are working on a vehicle management system. So far, they have created classes called `Auto` and `Motorcycle` to represent automobiles and motorcycles. After having noticed common information and calculations they were performing for each type of vehicle, they decided to break out the commonality into a separate class called `WheeledVehicle`. This is what their code looks like so far:  

```ruby
class WheeledVehicle
  attr_accessor :speed, :heading
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20, 20], 80, 8.0)
  end
end
```

Now Alan has asked them to incorporate a new type of vehicle into their system--a `Catamaran` defined as follows:  

```ruby
class Catamaran
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end
```

This new class does not fit well with the object hierarchy defined so far. Catamarans don't have tires. But we still want common code to track fuel efficiency and range. Modify the class definitions and move code into a Module, as necessary, to share code among the `Catamaran` and the wheeled vehicles.

**My Response:**  

```ruby
module Drivable
  def range
    @fuel_capacity * @fuel_efficiency
  end
  
  def fuel_efficiency
    @fuel_efficiency
  end
end

# remove the `range` method from the `WheeledVehicle` class.
# make sure to add a `@fuel_efficiency` instance variable to the `Catamaran` class.
```

**Launch School's Response:**  

We can move anything shared with the catamaran and wheeled vehicles into a new module (let's call `Moveable`) that we include in both individual classes.  

Also, in the initializers of the classes that include the `Moveable` module, we must reference the setter methods that have been defined in `Moveable` (the fuel capacity and efficiency) using `self.` notation. Otherwise, this would be interpreted as setting local variables that will lose their scope as soon as the initializers return.

```ruby
module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Catamaran
  include Moveable
  
  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    
    # ... other code to track catamaran-specific data omitted ...
  end
end
```

The definitions of `Auto` and `Motorcycle` can remain unchanged, since they both inherit from `WheeledVehicle` and we've moved any code shared between `Catamaran` and `WheeledVehicle` to the `Moveable` module.

---

###### Question 3  

Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similiar to a catamaran. Therefore, creators of `Motorboat` instances don't need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new `Motorboat` class?  

**My Response:**  

We could make a `Motorboat` class that inherits from the `Catamaran` class but which has its own `initialize` method that excludes the need for the user to specify the number of propellers and number of hulls. Instead, the `initialize` method sets both of those properties at 1.

```ruby
class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    self.propeller_count = 1
    self.hull_count = 1
  end
end
```

**Launch School's Response:**  

We can create a new class to present the common elements of motorboats and catamarans. We can call it, for example, `Seacraft`. We still want to include the `Moveable` module to get the support for calculating the range.

```ruby
class Seacraft
  include Moveable
  
  attr_reader :hull_count, :propeller_count
  
  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end
```

We can now implement `Motorboat` based on the `Seacraft` definition. We don't need to include a reference to `Moveable` since that is already included in the `Seacraft` super class.

```ruby
class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
```

And we alter the `Catamaran` to inherit from `Seacraft` and move hull and propeller out since it's taken over by `Seacraft`. We can also remove the reference to the `Moveable` module.

```ruby
class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
```

The `super` method automatically receives and passes along any arguments which the original method received. Because of that, we can remove the arguments being passed into super:  

```ruby
class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_travelled_per_liter, liters_of_fuel_capacity)
    super
  end
end
```

In fact, because `super` is the only statement in this `initialize` method and there's nothing to override, we can remove it altogether.

```ruby
class Catamaran < Seacraft
end
```

---

###### Question 4  

The designers of the vehicle management system now want to make an adjustment for how the `range` of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel.  

Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before, but for catamarans and motorboats, the range method will return an additional 10km.  

**My Response:**  

We can keep the `range` method within the `Moveable` module the same, but we can create a new `range` method within the `Seacraft` class that overrides but still utilizes that from the `Moveable` module.

```ruby
class Seacraft
  include Moveable
  
  attr_reader :hull_count, :propeller_count
  
  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
  
  def range
    super + 10
  end
end
```



