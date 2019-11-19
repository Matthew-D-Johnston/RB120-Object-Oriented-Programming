

## RPS Bonus Features

### RPS Bonus Feature: Keeping Score

---

**Problem:**  

Right now, the RPS game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun--a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.

---

### Score as a New Class

---

**Code:**

```ruby
class Score
  attr_reader :value

  def initialize
    @value = 0
  end
  
  def add_point
    @value += 1
  end

  def reset_score
    @value = 0
  end
end
```

---

### Score as a New State

---

```ruby
class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end
```

---

### RPS Bonus Feature: Add Lizard and Spock

---

**Problem:**  

This is a variation on the normal Rock Paper Scissors game by adding two more options--Lizard and Spock. The full explanation and rules are [here](http://www.samkass.com/theories/RPSSL.html).  

Rock beats...

* Scissors
* Lizard

Paper beats...

* Rock
* Spock

Scissors beats...

* Paper
* Lizard

Lizard beats...

* Paper
* Spock

Spock beats...

* Scissors
* Rock

---

**Code:**  

Main changes made to the `Move` class:

```ruby
class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def rocks_victims?(move)
    move.scissors? || move.lizard?
  end

  def papers_victims?(move)
    move.rock? || move.spock?
  end

  def scissors_victims?(move)
    move.paper? || move.lizard?
  end

  def lizards_victims?(move)
    move.paper? || move.spock?
  end

  def spocks_victims?(move)
    move.scissors? || move.rock?
  end

  def rocks_conquerers?(move)
    move.paper? || move.spock?
  end

  def papers_conquerers?(move)
    move.scissors? || move.lizard?
  end

  def scissors_conquerers?(move)
    move.rock? || move.spock?
  end

  def lizards_conquerers?(move)
    move.scissors? || move.rock?
  end

  def spocks_conquerers?(move)
    move.paper? || move.lizard?
  end

  def >(other_move)
    if rock?
      rocks_victims?(other_move)
    elsif paper?
      papers_victims?(other_move)
    elsif scissors?
      scissors_victims?(other_move)
    elsif lizard?
      lizards_victims?(other_move)
    elsif spock?
      spocks_victims?(other_move)
    end
  end

  def <(other_move)
    if rock?
      rocks_conquerers?(other_move)
    elsif paper?
      papers_conquerers?(other_move)
    elsif scissors?
      scissors_conquerers?(other_move)
    elsif lizard?
      lizards_conquerers?(other_move)
    elsif spock?
      spocks_conquerers?(other_move)
    end
  end

  def to_s
    @value
  end
end
```

Other changes were minor.

---

### RPS Bonus Feature: Add a class for each move

---

**Problem:**  

What would happen if we went even further and introduced 5 more classes, one for each move: `Rock`, `Paper`, `Scissors`, `Lizard`, and `Spock`. How would the code change? Can you make it work? After you're done, can you talk about whether this was a good design decision? What are the pros/cons?

---

```ruby
class Rock
  attr_reader :name, :prey, :predators
  
  def initialize
    @name = 'rock'
    @prey = ['lizard', 'scissors']
    @predators = ['paper', 'spock']
  end
end

...
```

Then...

```ruby
def display_winner
  if human.move.prey.include?(computer.move.name)
    puts "#{human.name} won!"
  elsif human.move.predators.include?(computer.move.name)
    puts "#{computer.name} won!"
  else
    puts "It's a tie!"
  end
end
```

Also...

```ruby
class Player
  attr_accessor :move, :name, :score

  POSSIBLE_MOVES = { rock: Rock.new, paper: Paper.new,
                     scissors: Scissors.new, lizard: Lizard.new,
                     spock: Spock.new }

  def initialize
    set_name
    @score = 0
  end
end
```

And...

```ruby
  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.to_sym
      break if POSSIBLE_MOVES.keys.include?(choice)
      puts "Sorry, invalid choice."
    end

    self.move = POSSIBLE_MOVES[choice]
  end

  def choose
    self.move = POSSIBLE_MOVES.values.sample
  end
```

---

### RPS Bonus Feature: Keep track of a history of moves

---

**Problem:**  

As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?

---

**Data Structure:**  

The moves will be stored in an array format, which will be encapsulted in the `Player` class under the class variable name of `move_history` and initiatialized whenever a new player is created. Thus, each player will have their own move history. For example,

```ruby
Matt.move_history => ['rock', 'lizard', 'spock']
```

The display output will be a table where the rows correspond to rounds of the RPS game and the columns correspond to the two names. Populating the table will be the correpsonding moves for each round and player. For example,

```
			 Matt			  Hal
	1   'rock'		'lizard'
	2		'spock'		'paper'
```

Every time the `choose` method is called, the move will be added to the respective player's move history.

```ruby
  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.to_sym
      break if POSSIBLE_MOVES.keys.include?(choice)
      puts "Sorry, invalid choice."
    end

    self.move = POSSIBLE_MOVES[choice]
    move_history << self.move.name
  end

# and for the computer,

  def choose
    self.move = POSSIBLE_MOVES.values.sample
    move_history << self.move.name
  end
```

Here is the new `Player` class definition:

```ruby
class Player
  attr_accessor :move, :name, :score, :move_history

  POSSIBLE_MOVES = { rock: Rock.new, paper: Paper.new,
                     scissors: Scissors.new, lizard: Lizard.new,
                     spock: Spock.new }

  def initialize
    set_name
    @score = 0
    @move_history = []
  end
end
```

Now create a new `display_move_history` method in the `RPSGame` class.

```ruby
  def display_move_history
    puts " "*6 + "#{human.name}" + " "*(20 - human.name.length) + "#{computer.name}"
  
    1.upto(human.move_history.size) do |n|
      puts "#{n}" + " "*(6 - n.to_s.length) + "#{human.move_history[n - 1]}" + " "*(20 - (human.move_history[n - 1].length)) + "#{computer.move_history[n - 1]}"
    end
  end
```

---

### RPS Bonus Feature: Computer personalities

---

**Problem:**  

We have a list of robot names for our `Computer` class, but other than the name, there's really nothing different about each of them. It'd be interesting to explore how to build different personalities for each robot. For example, R2D2 can always choose "rock". Or, "Hal" can have a very high tendency to choose "scissors", and rarely "rock", but never "paper". You can come up with the rules or personalities for each robot. How would you approach a feature like this?

---

Should be able to include this functionality within the `choose` method of the `Computer` class, perhaps by using a `case` statement...

```ruby
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    case name
    when "R2D2"
      self.move = Rock.new
    when "Hal"
      self.move = [Scissors.new, Scissors.new, Scissors.new, Rock.new, Lizard.new, 	
        					 Lizard.new, Spock.new, Spock.new].sample
    when "Chappie"
      self.move = [Rock.new, Paper.new, Scissors.new].sample
    when "Sonny"
      self.move = [Rock.new, Paper.new, Scissors.new, Lizard.new, Lizard.new, Spock.new, 
        					 Spock.new].sample
    when "Number 5"
    	self.move = POSSIBLE_MOVES.values.sample
    end
    
    move_history << move.name
  end
end
```



