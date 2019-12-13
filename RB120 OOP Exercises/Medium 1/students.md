# RB120 - Object Oriented Programming

## Medium 1

### Students  

Below we have 3 classes: `Student`, `Graduate`, and `Undergraduate`. Some details for these classes are missing. Make changes to the classes below so that the following requirements are fulfilled:  

1. Graduate students have the option to use on-campus parking, while Undergraduate students do not.
2. Graduate and Undergraduate students have a name and year associated with them.

```
Note, you can do this by adding or altering no more than 5 lines of code.
```

```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate
  def initialize(name, year, parking)
  end
end

class Undergraduate
  def initialize(name, year)
  end
end
```

---

**My Solution:**  

```ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end
```

---

**Further Exploration:**  

There is one other "form" of the keyword `super`. We can call it as `super()`. This calls the superclass method of the same name as teh calling method, but here no arguments are passed to the superclass method at all.  

Can you think of a way to use `super()` in another Student related class?  

**My Solution:**  

```ruby
class StudentBody
  @@total_students = 0

  def initialize
    @@total_students += 1
    @student_number = @@total_students
  end
end

class Student < StudentBody
  def initialize(name, year)
    @name = name
    @year = year
    super()
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end
```

