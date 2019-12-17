# RB120 - Object Oriented Programming

## Medium 1

### Deck of Cards  

Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards. Use the following code to start your work:

```ruby
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
end
```

The Deck class should provide a `#draw` method to draw one card at random. If the deck runs out of cards, the deck should reset itself by generating a new set of 52 cards.  

Examples:

```ruby
deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.
```

Note that the last line should almost always be true; if you shuffle the deck 1000 times a second, you will be very, very, very old before you see two consecutive shuffles produce the same results. If you get a false result, you almost certainly have something wrong.

---

**My Solution:**  

What we want whenever a new `Deck` object is created is to initialize a new deck of 52 unique cards. We can thus create a `@full_deck` instance variable that is initialized whenever a `Deck` object is instantiated.  

This `@full_deck` instance variable will be an array of 52 `Card` objects. To create this variable we will need to iterate through the `SUITS` array, and for each suit we then iterate through the `RANKS` array, using each unique combination of suits and ranks to create a new `Card` object (i.e. `Card.new(rank, suit)`).  

```ruby
def initialize
  @full_deck = SUITS.map{ |suit| RANKS.map { |rank| Card.new(rank, suit) } }.flatten
end			
```

That should create a full deck of 52 unique cards.  

Now, we need to create our `draw` method that selects one card at random, and generates a new deck if the deck runs out of cards.

```ruby
def draw
  @full_deck = generate_new_deck if @full_deck.empty?
  @full_deck.shuffle!.pop
end

def generate_new_deck
  SUITS.map{ |suit| RANKS.map { |rank| Card.new(rank, suit) } }.flatten
end
```

Thus, we have our `Deck` class:

```ruby
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @full_deck = generate_new_deck
  end
  
  def generate_new_deck
    SUITS.map{ |suit| RANKS.map { |rank| Card.new(rank, suit) } }.flatten
  end
  
  def draw
    @full_deck = generate_new_deck if @full_deck.empty?
    @full_deck.shuffle!.pop
  end
end  
```

---

**Launch School's Solution:**

```ruby
# insert Card class from previous exercise here

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    reset
  end
  
  def draw
    reset if @deck.empty?
    @deck.pop
  end
  
  private
  
  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
    
    @deck.shuffle!
  end
end
```



