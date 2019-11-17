

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