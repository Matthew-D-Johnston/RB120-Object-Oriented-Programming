##### RB120 - Object Oriented Programming > Debugging > Animal Kingdom

---

## Animal Kingdom

The code below raises an exception. Examine the error message and alter the code so that it runs without error.  

```ruby
class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')
```

---

**Analysis of the Problem:**  

When the above code is run, the following output is produced:

```
animal_kingdom.rb:4:in `initialize': wrong number of arguments (given 3, expected 2) (ArgumentError)
	from animal_kingdom.rb:39:in `initialize'
	from animal_kingdom.rb:52:in `new'
	from animal_kingdom.rb:52:in `<main>'
```

It appears that the problem originates on line 52 with the following piece of code:

```ruby
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')
```

The error message indicates that we have used the wrong number of arguments when we invoke the `new` method on our `SongBird` class.  

The error stack shows that line 39 was also crucial for producing the error, which is the line where we invoke the `super` method within our constructor method `initialize` in the `SongBird` class definition.

```ruby
class SongBird < Bird
  def initialize(diet, superpower, song)
    super														# this line is crucial in producing the error.
    @song = song
  end
  
  # ... rest of code omitted for brevity.
```

The problem is that our constructor method in the `SongBird` class does not seem to recognize the additional `song` parameter because we have called `super`. Thus, our constructor method merely imitates the constructor method of the superclass `Animal`. The solution will need to ensure that the `initialize` constructor method in the `SongBird` class allows for the passage of a third argument, namely `song`.

---

**My Solution:**  

We can solve the problem by appending `(diet, superpower)` to the call to the `super` method on line 39.

```ruby
class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)							# (diet, superpower) appended to super.
    @song = song
  end
  
  # ... rest of code omitted for brevity.
```

That allows the program to run smoothly and a new `SongBird` object to be created without an exception being raised.

