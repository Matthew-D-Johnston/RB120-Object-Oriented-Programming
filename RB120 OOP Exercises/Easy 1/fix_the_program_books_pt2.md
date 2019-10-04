### Fix the Program - Books (Part 2)

---

**Problem:**



Complete this program so that it produces the expected output:

```ruby
class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{boook}.)
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
  attr_accessor :title, :author	 # Added the accessor methods for the two inst. var.
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

---

**Further Exploration:**



What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps.



Answer: Separating the steps requires that a setter method be introduced into the class so that we can later set the book title and author. The only danger to this is that it now allows the possibility to reassign a new title or author to the `Book` object. This may or may not be desirable. It could lead to unexpected changes later, and such a possibility may be an incentive to only set the title and author states at initialization.