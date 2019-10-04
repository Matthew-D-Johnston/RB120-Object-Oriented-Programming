### Fix the Program - Books (Part 1)

----

**Problem:**



Complete this program so that it produces the expected output:

```ruby
class Book
  def initialize(author, title)
    @author = author
    @title = title
  end
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

Expected output:

```
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
```

---

**Solution:**

```ruby
class Book
  attr_reader :author, :title				# Added this line of code.

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

---

**Further Exploration:**



What are the differences between `attr_reader`, `attr_writer`, and `attr_accessor`? Why did we use `attr_reader` instead of one of the other two? Would it be okay to use one of the other? Why or why not?



Answer: Using `attr_writer` would have allowed us to reassign the `@author` and `@title` instance variables but it would not have allowed us to call their current values, which is what we needed for what we wanted to do in this program. On the other hand, `attr_accessor` would have allowed us to call their current values, but it also would have given us additional reassignment capabilities. Since we did not need reassignment capabilities for the purpose of the program, it's probaly best not to bring in additional functionality because that could lead to possible reassignment when we don't intend it.

---

Instead of `attr_reader`, suppose you had added the following methods to this class:

```ruby
def title
  @title
end

def author
  @author
end
```

Would this change the behaviour of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?



Answer: Not, it would not have affected the behaviour of the class in any way. The reason is because this is just an equivalent, albeit perhaps more explicit, way of allowing us to call the current values of our instance variables. It does the same thing as `attr_reader`. If there is an advantage to doing it in that way, it is probabl just that it is more explicit that what we are defining is a method, whereas `attr_reader` is more of a short cut. It's more efficient and better to use so long as we know that it is equivalent to the longer method defintions. 

