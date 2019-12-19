##### RB120 - Object Oriented Programming > Debugging > Wish You Were Here

---

## Wish You Were Here

On lines 37 and 38 of our code, we can see that `grace` and `ada` are located at the same coordinates. So why does line 39 output `false`? Fix the code to produce the expected output.

```ruby
class Person
  attr_reader :name
  attr_accessor :location
  
  def initialize(name)
    @name = name
  end
  
  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location										# (-33.89, 151.277)
puts grace.location 								# (-33.89, 151.277)
puts ada.location == grace.location	# expected: true
																		# actual: false
```

---

**Analysis of the Problem:**  

My hunch is that `ada.location` is referencing a completely different GeoLocation object than is `grace.location`. Although when `puts` is called on each, both print an identical String object to the screen, it is not their String representations that are being compared in the line `puts ada.location == grace.location`.

---

**My Solution:**  

In order to fix the above problem, we can append both `ada.location` and `grace.location` with a `to_s` method call. That way we will be comparing their respective String representations rather than two separate GeoLocation objects.

```ruby
puts ada.location.to_s == grace.location.to_s
# true
```

---

**Launch School's Solution:**  

```ruby
class GeoLocation
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def ==(other)
    latitude == other.latitude && longitude == other.longitude
  end
  
  def to_s
    "(#{latitude}, #{longitude})"
  end
end
```

###### Discussion  

On line 39 of our original code, we invoke the `==` method to compare the equality of two locations. Since our `GeoLocation` class does not implement `==`, Ruby invokes the method from the `BasicObject` class. `BasicObject#==`, however, returns `true` only if the two objects being compared are the _same object_, or in other words, if they have the same object id.  

In order to compare the equality of instances of our custom class based on the value of their attributes, we need to define a `==` method in our custom class, which _overrides_ `BasicObject#==` (thanks to Ruby's method lookup path). `GeoLocation#==` does exactly that: it compares two locations based on their latitude and longitude values.