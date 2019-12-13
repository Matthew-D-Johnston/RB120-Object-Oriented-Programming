# RB120 - Object Oriented Programming

## Medium 1

### Fixed Array  

A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:  

```ruby
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
```

The above code should output `true` 16 times.

---

**My Solution:**  

```ruby
class FixedArray
  def initialize(length)
    @fixed_array = [nil] * length
    @max_index = length - 1
  end
  
  def [](index)
    if (0..@max_index).include?(index) || index < 0
    	@fixed_array[index]
    else
      raise IndexError
    end
  end
  
  def to_a
    @fixed_array
  end
  
  def []=(index, value)
    if (0..@max_index).include?(index) || index < 0
    	@fixed_array[index] = value
    else
      raise IndexError
    end
  end
  
  def to_s
    @fixed_array.to_s
  end
end
```

---

**Launch School's Solution:**  

```ruby
class FixedArray
  def initialize(max_size)
    @array = Array.new(max_size)
  end
  
  def [](index)
    @array.fetch(index)
  end
  
  def []=(index, value)
    self[index]							# raise error if index is invalid!
    @array[index] = value
  end
  
  def to_a
    @array.clone
  end
  
  def to_s
    to_a.to_s
  end
end
```

