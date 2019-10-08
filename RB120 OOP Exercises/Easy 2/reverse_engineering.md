### Reverse Engineering

---

**Problem:**  

Write a class that will display:

```
ABC
xyz
```

when the following code is run:

```ruby
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
```

---

**My Solution:**  

```ruby
class Transform
  def initialize(input)
    @input = input
  end
  
  def uppercase
    @input.upcase
  end
  
  def self.lowercase(input)
    input.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
```



