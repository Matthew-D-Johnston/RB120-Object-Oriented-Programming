# RB120 - Object Oriented Programming

## Debugging

### Community Library  

On line 42 of our code, we intend to display information regarding the books currently checked in to our community library. Instead, an exception is raised. Determine what caused this error and fix the code so that the data is displayed as expected.  

```ruby
class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

community_library.books.display_data
```

---

**Analysis of the Problem:**  

Indeed, when the program is run, the following error message is produced:

```
community_library.rb:44:in `<main>': undefined method `display_data' for #<Array:0x00007f86031ad980> (NoMethodError)
Did you mean?  display
```

My hunch is that the `display_data` method is an instance method within the `Book` class, which means that it can be called on individual `Book` objects. The problem is that `books` is a getter method to retrieve the `Array` object associated with the instance variable `@books`, which is part of the `Library` class. Thus, `display_data` is being called on an `Array` object, not `Book` object.  

---

**My Solution:**   

In order to display the data associated with the individual books that have been checked into the community library, we will need to iterate over the `@books` array with the `each` method and call the `display_data` instance method on each of the individual `Book` objects.

```ruby
community_library.books.each { |book| book.display_data }
```

This code revision produces the expected output:

```
---------------
Title: Learn to Program
Author: Chris Pine
ISBN: 978-1934356364
---------------
---------------
Title: Little Women
Author: Louisa May Alcott
ISBN: 978-1420951080
---------------
---------------
Title: A Wrinkle in Time
Author: Madeleine L'Engle
ISBN: 978-0312367541
---------------
```

