### Buggy Code - Car Mileage

---

**Problem:**  

Fix the following code so it works properly:

```ruby
class Car
  attr_accessor :mileage
  
  def initialize
    @mileage = 0
  end
  
  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end
  
  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage 	# should print 5678
```

However, the following is printed...

```
5000
```

...showing no permanent effect of the `increment_mileage` method call.

---

**My Solution:**  

```ruby
class Car
  attr_accessor :mileage
  
  def initialize
    @mileage = 0
  end
  
  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total					# or @mileage = total
  end
  
  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage
```

