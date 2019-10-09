### What Will This Do?

---

**Problem:**  

What will the following code print?

```ruby
class Something
  def initialize
    @data = 'Hello'
  end
  
  def dupdata
    @data + @data
  end
  
  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
```

---

**Expected Print Out:**

```
ByeBye
HelloHello
```

