# RB120 - Object Oriented Programming

## Medium 1

### Highest and Lowest Ranking Cards  

Update this class so you can use it to determine the lowest ranking and highest ranking cards in an `Array` of `Card` objects:  

```ruby
class Card
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end
```

For this exercise, numeric cards are low cards, ordered from 2 through 10. Jacks are higher than 10s, Queens are higher than Jacks, Kings are higher than Queens, and Aces are higher than Kings. The suit plays no part in the relative ranking of cards.  

If you have two or more cards of teh same rank in your list, your `min` and `max` methods should return one of the matching cards; it doesn't matter which one.  

Besides any methods needed to determine the lowest and highest cards, create a `#to_s` method that returns a String representation of the card, e.g., `"Jack of Diamonds"`, `"4 of Clubs"`, etc.  

Examples:

```ruby
cards = [Card.new(2, 'Hearts'),
  			 Card.new(10, 'Diamonds'),
  			 Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
  			 Card.new(4, 'Diamonds'),
  			 Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
  			 Card.new('Jack', 'Diamonds'),
  			 Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
  			 Card.new(8, 'Clubs'),
  			 Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
```

Output:

```
2 of Hearts
10 of Diamonds
Ace of Clubs
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

---

**My Solution:**  

In defining either the `min` or the `max` method we will need to come up with some way of dealing with the non-numeric face cards (i.e. the Jack, Queen, King, and Ace).

We shall handle these face cards by defining a method that assigns a value that to each of these face cards while respecting the order hierarchy (i.e. Jack < Queen < King < Ace). So, something like Jack = 11, Queen = 12, King = 13, and Ace = 14.  

```ruby
def assign_numerical_rank(face)
  if ('2'..'10').to_a.include?(face)
    face.to_i
  else
    case face
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end
end      
```

Now, we will need to define the spaceship operator, `<=>`, so that Ruby knows how to compare separate `Card` objects.

```ruby
def <=>(other)
  rank_value = assign_numerical_rank(self.rank)
  other_value = assign_numerical_rank(other.rank)
  
  rank_value <=> other_value
end  
```

Let's insert these two methods into our `Card` class:

```ruby
class Card
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def assign_numerical_rank(face)
    return face if (2..10).include?(face)
    case face
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end
        
  def <=>(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value <=> other_value
  end
  
end
```

It looks like we will also need to redefine the equality-checking operator, `==`, in order that when it is invoked it will compare the ranks of each card:

```ruby
def ==(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value == other_value
end
```

Now, our `Card` class looks like the following:

```ruby
class Card
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def assign_numerical_rank(face)
    return face if (2..10).include?(face)
    case face
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end
        
  def <=>(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value <=> other_value
  end
  
  def ==(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value == other_value
  end
end
```

We now need to create a `to_s` method that returns a String representation of the card, e.g., `"Jack of Diamonds"`, `"4 of Clubs"`, etc.

```ruby
def to_s
  "#{rank} of #{suit}"
end
```

So, the `Card` class now looks like this:

```ruby
class Card
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def assign_numerical_rank(face)
    return face if (2..10).include?(face)
    case face
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end
        
  def <=>(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value <=> other_value
  end
  
  def ==(other)
    rank_value = assign_numerical_rank(self.rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value == other_value
  end
      
  def to_s
    "#{rank} of #{suit}"
  end
end
```

---

**Launch School's Solution:**  

```ruby
class Card
  include Comparable
  attr_reader :rank, :suit
  
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
  
  def value
    VALUES.fetch(rank, rank)
  end
  
  def <=>(other_card)
    value <=> other_card.value
  end
end
```

---

**Further Exploration:**  

Assume you're playing a game in which cards of the same rank are unequal. In such a game, each suit also has a ranking. Suppose that, in this game, a 4 of Spades outranks a 4 of Hearts which outranks a 4 of Clubs which outranks a 4 of Diamonds. A 5 of Diamonds, though, outranks a 4 of Spades since we compare ranks first. Upate the Card class so that `#min` and `#max` pick the card of the appropriate suit if two or more cards of the same rank are present in the Array.  

**My Solution:**  

So, we have:

```
Spades > Hearts > Clubs > Diamonds
```

So, the updated `Card` class will look something like this:

```ruby
class Card
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def assign_numerical_rank(face)
    return face if (2..10).include?(face)
    
    case face
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end

  def assign_numerical_value_to_suit(suit)
    case suit
    when 'Diamonds' then 1
    when 'Clubs' then 2
    when 'Hearts' then 3
    when 'Spades' then 4
    end
  end
        
  def <=>(other)
    rank_value = assign_numerical_rank(rank)
    other_value = assign_numerical_rank(other.rank)

    if rank_value != other_value
      rank_value <=> other_value
    else
      suit_value = assign_numerical_value_to_suit(suit)
      other_suit_value = assign_numerical_value_to_suit(other.suit)
      suit_value <=> other_suit_value
    end
  end
  
  def ==(other)
    rank_value = assign_numerical_rank(rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value == other_value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end
```





