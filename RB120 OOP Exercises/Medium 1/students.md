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

