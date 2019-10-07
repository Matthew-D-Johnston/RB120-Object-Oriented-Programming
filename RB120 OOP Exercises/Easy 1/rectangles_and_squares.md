### Rectangles and Squares

---

**Problem:**  

Given the following class:

```ruby
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end
  
  def area
    @height * @width
  end
end
```

Write a class called `Square` that inherits from Rectangle, and is used like this:

```ruby
square = Square.new(5)
puts "area of square = #{square.area}"
```

---

**My Solution:**  

```ruby
class Square < Rectangle
  def initialize(side_lengths)
    @height = side_lengths
    @width = side_lengths
  end
end
```

---

**Launch School's solution:**

```ruby
class Square < Rectangle
  def initialize(length_of_side)
    super(length_of_side, length_of_side)
  end
end
```

