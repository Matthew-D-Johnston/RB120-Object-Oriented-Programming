##### RB120 - Object Oriented Programming > Debugging > Sorting Distances

---

## Sorting Distances

When attempting to sort an array of various lengths, we are surprised to see that an `ArgumentError` is raised. Make the necessary changes to our code so that the various lengths can be properly sorted and line 62 produces the expected output.  

```ruby
class Length
  attr_reader :value, :unit
  
  def initialize(value, unit)
    @value = value
    @unit = unit
  end
  
  def as_kilometers
    convert_to(:km, { km: 1, mi: 0.62113711, nmi: 0.539957 })
  end
  
  def as_miles
    convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
  end
  
  def as_nautical_miles
    convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
  end
  
  def ==(other)
    case unit
    when :km 	then value == other.as_kilometers.value
    when :mi 	then value == other.as_miles.value
    when :nmi then value == other.as_nautical_miles.value
    end
  end
      
  def <(other)
    case unit
    when :km 	then value < other.as_kilometers.value
    when :mi 	then value < other.as_miles.value
    when :nmi then value < other.as_nautical_miles.value
    end
  end
  
  def <=(other)
    self < other || self == other
  end
      
  def >(other)
    !(self <= other)
  end
      
  def >=(other)
    self > other || self == other
  end
      
  def to_s
    "#{value} #{unit}"
  end
      
  private
      
  def convert_to(target_unit, conversion_factors)
    Length.new((value / conversion_factors[unit]).round(4), target_unit)
  end
end
      
# Example
      
puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi
```

---

**Analysis of the Problem:**  

Here is the error message that is output to the screen when the code is run:

```
sorting_distances.rb:60:in `sort': comparison of Length with Length failed (ArgumentError)
	from sorting_distances.rb:60:in `<main>'
```

According to the Ruby documentation for the [`sort` method](https://ruby-doc.org/core-2.6.3/Array.html#method-i-sort), "Comparisons for the sort will be done using the <=> operator or using an optional code block." This suggests that we need to explicitly define the spaceship operator, `<=>`.  

**My Solution:**  

Let's try the following:

```ruby
def <=>(other)
  case unit
  when :km  then value <=> other.as_kilometers.value
  when :mi  then value <=> other.as_miles.value
  when :nmi then value <=> other.as_nautical_miles.value
  end
end
```

That works and produces the expected output:

```
1 km
1 mi
1 nmi
```

It also works if we get rid of the other comparison methods (i.e. `==`,  `<`, `<=`, `>`, and `>=`). However, on this point, Launch School notes that we must add the line `include Comparable`.

---

