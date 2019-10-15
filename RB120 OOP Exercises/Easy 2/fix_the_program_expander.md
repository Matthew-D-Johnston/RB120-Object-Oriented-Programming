### Fix the Program - Expander

---

What is wrong with the following code? What fix(es) would you make?

```ruby
class Expander
  def initialize(string)
    @string = string
  end
  
  def to_s
    self.expand(3)
  end
  
  private
  
  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
```

---

**My Response:**



We would expect the output to be:

```
xyzxyzxyz
```

But instead, an exception is raised indicating the invoking of `to_s` by the `puts` method tries to invoke the private method `expand`. Thus, we can either change `expand` to a protected method or leave it a private method and remove the `self` that is prepended to `.expand(3)` within the `to_s` method definition.



Option 1:

```ruby
class Expander
  def initialize(string)
    @string = string
  end
  
  def to_s
    self.expand(3)
  end
  
  protected 									# changed from private
  
  def expand(n)
    @string * n
  end
end
```

Option 2:

```ruby
class Expander
  def initialize(string)
    @string = string
  end
  
  def to_s
    expand(3)
  end
  
  private
  
  def expand(n)
    @string * n
  end
end
```

