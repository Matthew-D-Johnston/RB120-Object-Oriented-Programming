# RB120 - Object Oriented Programming

## Medium 1

### Poker!  

In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.  

You should build your class using the following code skeleton:  

```ruby
# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
  end
  
  def print
  end
  
  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end
      
  private
      
  def royal_flush?
  end
      
  def straight_flush?
  end
      
  def four_of_a_kind?
  end
  
  def full_house?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def pair?
  end
end
```

Testing your class:

```ruby
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
```

Output:

```
5 of Clubs
7 of Diamonds
Ace of Hearts
7 of Clubs
5 of Spades
Two pair
true
true
true
true
true
true
true
true
true
true
true
true
true
```

The exact cards and the type of hand will vary with each run.  

Most variants of Poker allow both Ace-high (A, K, Q, J, 10) and Ace-low (A, 2, 3, 4, 5) straights. For simplicity, your code only needs to recognize Ace-high straights.

---

**My Solution:**  

Let's first think about the `initialize` method of the `PokerHand` class. We will want to initialize a hand, and we might store this as an `Array` object whose elements are individual `Card` objects drawn from the `Deck` class. The `Array` object will hold five different `Card` objects and we will assign it to the instance variable `@hand`.

```ruby
def initialize(deck)
  new_hand(deck)
end

def new_hand(deck)
  @hand = []
  5.times { @hand << deck.draw }
end
```

Let's now define our `print` method which will print each of the cards in the hand to the screen.

```ruby
def print
  puts @hand
end
```

Here's what we have for our `PokerHand` class so far:

```ruby
class PokerHand
  def initialize(deck)
    new_hand(deck)
  end
  
  def new_hand(deck)
    @hand = []
  	5.times { @hand << deck.draw }
  end
  
  def print
    puts @hand
  end
  
  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end
end
```

Now, we need to define the individual methods that determine whether a specific poker hand corresponds to one of the special poker-hand cases (e.g. royal flush, full house, two pair, etc.).  

Let's start with the simplest; namely, `pair?`.

```ruby
def pair?
  @hand.map { |card| card.rank }.uniq.size == 4
end
```

Now, `two_pair?`.

```ruby
def two_pair?
  unique_ranks = @hand.map { |card| card.rank }.uniq
  unique_rank_count = unique_ranks.map { |rank| unique_ranks.count(rank) }
	unique_rank_count.count(2) == 2
end
```

Based on the above definition, I am going to create a new method called `number_of_pairs`, which can be used for both the `pair?` method and the `two_pair?` method.

```ruby
def number_of_identical_ranks(number)
  hand_ranks = @hand.map { |card| card.rank }
  unique_ranks = hand_ranks.uniq
  unique_rank_count = unique_ranks.map { |rank| hand_ranks.count(rank) }
  unique_rank_count.count(number)
end
```

Thus, we have:

```ruby
def pair?
  number_of_identical_ranks(2) == 1
end

def two_pair?
  number_of_identical_ranks(2) == 2
end
```

We should be able to define our `three_of_a_kind?` method fairly easily now, too.

```ruby
def three_of_a_kind?
  number_of_identical_ranks(3) == 1 && number_of_identical_ranks(2) == 0
end
```

And `four_of_a_kind?`:

```ruby
def four_of_a_kind?
  number_of_identical_ranks(4) == 1
end
```

And `full_house?`

```ruby
def full_house?
  number_of_identical_ranks(3) == 1 && number_of_identical_ranks(2) == 1
end
```

Let's think about our `straight?` method now. What we want is to convert face cards (Jack, Queen, King, and Ace) to an integer value so that we can compare them with the values 2 through 10. For a straight, we know that if we sort the ranks then the difference between the first and last card should be 4. Thus, if we use `sort` on the ranks of the hand, then we can see if the first element in the array subtracted from the last element in the array is equal to 4.  

But first, let's create a method called `hand_ranks`, which will first take our hand and create an array of the ranks. It will also convert the face cards to numerical equivalents (e.g. Queen = 12).

```ruby
def hand_ranks
  @hand.map do |card|
    case card.rank
    when 'Jack'  then 11
    when 'Queen' then 12
    when 'King'  then 13
    when 'Ace' 	 then 14
    else
      card.rank
    end
  end
end
```

This means we can also modify our `number_of_identical_ranks` method:

```ruby
def number_of_identical_ranks(number)
  unique_ranks = hand_ranks.uniq
  unique_rank_count = unique_ranks.map { |rank| hand_ranks.count(rank) }
  unique_rank_count.count(number)
end
```

So, now for the `straight?` method.

```ruby
def straight?
  sorted_ranks = hand_ranks.sort
  sorted_ranks.last - sorted_ranks.first == 4 && !flush?
end
```

Now, we can tackle the `flush?` method. A flush is just a hand where the suits of each card are the same. Let's first create a method that creates an array of the hand's suits.

```ruby
def hand_suits
  @hand.map { |card| card.suit }
end
```

Now for our `flush?` method.

```ruby
def flush?
  hand_suits.uniq.size == 1 && !straight?
end
```

Now, we can easily define a `straight_flush?` method.

```ruby
def straight_flush?
  sorted_ranks = hand_ranks.sort
  sorted_ranks.last - sorted_ranks.first == 4 && hand_suits.uniq.size == 1
end
```

Finally, we need to define our `royal_flush?` method.

```ruby
def royal_flush?
  sorted_ranks = hand_ranks.sort
  unique_ranks = sorted_ranks.uniq
  unique_suits = hand_suits.uniq
  last_rank_minus_first = sorted_ranks.last - sorted_ranks.first
  unique_ranks.size == 1 && unique_suits.size == 1 && last_rank_minus_first == 4
end
```

So, my final `PokerHand` class looks like the following:

```ruby
class PokerHand
  attr_reader :hand

  def initialize(deck)
    new_hand(deck)
  end
  
  def new_hand(deck)
    @hand = []
    5.times { @hand << deck.draw }
  end
  
  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def hand_ranks
    @hand.map do |card|
      case card.rank
      when 'Jack'  then 11
      when 'Queen' then 12
      when 'King'  then 13
      when 'Ace'   then 14
      else
        card.rank
      end
    end
  end

  def hand_suits
    @hand.map { |card| card.suit }
  end

  def number_of_identical_ranks(number)
    unique_ranks = hand_ranks.uniq
    unique_rank_count = unique_ranks.map { |rank| hand_ranks.count(rank) }
    unique_rank_count.count(number)
  end

  def royal_flush?
    sorted_ranks = hand_ranks.sort
    first = sorted_ranks.first
    last = sorted_ranks.last
    straight? && flush? && first == 10 && last == 14
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    number_of_identical_ranks(4) == 1
  end

  def full_house?
    number_of_identical_ranks(3) == 1 && number_of_identical_ranks(2) == 1
  end

  def flush?
    hand_suits.uniq.size == 1
  end

  def straight?
    sorted_ranks = hand_ranks.sort
    last_rank_minus_first = sorted_ranks.last - sorted_ranks.first
    last_rank_minus_first == 4 && sorted_ranks.uniq.size == 5
  end

  def three_of_a_kind?
    number_of_identical_ranks(3) == 1 && number_of_identical_ranks(2) == 0
  end

  def two_pair?
    number_of_identical_ranks(2) == 2
  end

  def pair?
    number_of_identical_ranks(2) == 1
  end
end
```

---

**Launch School's Solution:**  

```ruby
class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)
    
    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end
  
  def print
    puts @cards
  end
  
  def evaluate
    if    royal_flush?     then 'Royal flush'
    elsif straight_flush?  then 'Straight flush'
    elsif four_of_a_kind?  then 'Four of a kind'
    elsif full_house?      then 'Full house'
    elsif flush?           then 'Flush'
    elsif straight?        then 'Straight'
    elsif three_of_a_kind? then 'Three of a kind'
    elsif two_pair?        then 'Two pair'
    elsif pair?            then 'Pair'
    else 'High card'
    end
  end
  
  private
  
  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end
      
  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }
    
    @cards.min.value == @cards.max.value - 4
  end
  
  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end
      
  def straight_flush?
    flush? && straight?
  end
      
  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end
      
  def four_of_a_kind?
    n_of_a_kind?(4)
  end
      
  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end
      
  def three_of_a_kind?
    n_of_a_kind?(3)
  end
      
  def two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end
      
  def pair?
    n_of_a_kind?(2)
  end
end
```

---

**Further Exploration:**  

The following questions are meant to be thought exercises; rather than write code, think about what you would need to do. Feel free to write some code after thinking about the problem.  

How would you modify this class if you wanted the individual classification methods (`royal_flush?`, `straight?`, `three_of_a_kind?`, etc.) to be public class methods that work with an Array of 5 cards, e.g.,

```ruby
def self.royal_flush?(cards)
  ...
end
```

How would you modify our original solution to choose the best hand between two poker hands?  

How would you modify our original solution to choose the best 5-card hand from a 7-card poker hand?

