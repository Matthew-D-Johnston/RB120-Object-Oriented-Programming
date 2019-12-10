# Lesson 5: Slightly Larger OO Programs

## 8. Assignment: OO Twenty-One

Here is Launch School's initial "spike" code for the OO Twenty-One game:

```ruby
class Player
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer
  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  # what goes in here? all the redundant behaviours from Player and Dealer?
end

class Deck
  def initialize
    # obviously, we need some data structure to keep track of cards
    # array, hash, or something else?
  end

  def deal
    # does the dealer or the deck deal?
  end
end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start
```

---

As instructed, I will take a shot at my own solution for the game.  

First, I think that I will eliminate the separate `Player` and `Dealer` classes and create one `Participant` class, but include a state that contains the participant's status; namely, whether they are a 'dealer' or just a 'player'.  

At this point, I will also reserve the `deal` method for the `Deck` class. Also, `@total` should be an instance variable that is initialized with a value of `0` when each `Participant` object is instantiated. We will want to be able to read and write this variable later so we need to create an `attr_accessor` with it.

Something like this:

```ruby
class Participant
  attr_accessor :total
  
  def initialize(status)
    @status = status			# 'dealer' or 'player'
    @total = 0
  end
  
  def hit
  end
  
  def stay
  end
  
  def busted
  end
end
```

In thinking about the `Deck` class, we will want it to have some attribute that contains all of the cards. Thus, we want some data structure, like an array or a hash, that is capable of holding a group of cards. The cards themselves, I think should be individual card objects.  

Let's think about a `Card` class and the kind of attributes that should be associated with a `Card` object. We will want a `@suit` instance variable to keep track of the card's suit (i.e. club, heart, diamond, or spade), and a `@rank` instance variable to keep track of the card's rank (e.g. '5', '8', 'jack', or 'ace'). We also need a way to keep track of the cards value that is specific to the game of twenty-one; that is, if we are dealing with a "two of hearts", then the value is 2, whereas the value of a "king of diamonds" is 10, and the value of an "ace of spades" is either 1 or 11.

```ruby
class Card
  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
  end
end
```

Now, let's return to thinking about the `Deck` class. Let's do a bit of spike just to test some things out:

```ruby
class Deck
  SUITS = ["clubs", "spades", "hearts", "diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]
  
  def initialize
    @deck = SUITS.map { |suit| RANKS.map { |rank| Card.new(suit, rank) } }.flatten
  end
  
  def shuffle_deck
    @deck.shuffle!
  end
  
  def deal_top_card
    @deck.pop
  end
end              
```

Let's now think about how to initialize the value of the `@value` instance variable in the `Card` class.

```ruby
class Card < Deck
  attr_reader :suit, :rank, :value
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    if rank == 'ace'
      @value = [1, 11]
    elsif rank.to_i == 0
    	@value = 10
    else
      @value = rank.to_i
    end
  end
end
```

Now, thinking about the `Participant` class again, it might be helpful to include an `@hand` instance variable in order to keep track of each participant's hand:

```ruby
class Participant
  attr_reader :status
  attr_accessor :total, :hand
  
  def initialize(status)
    @status = status			# 'dealer' or 'player'
    @total = 0
    @hand = []						# an Array object that will contain Card objects.
  end
  
  def hit
  end
  
  def stay
  end
  
  def busted
  end
end
```

Now, let's get to our `Game` class again:

```ruby
class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end
```

Let's think about what we want the `Game` class to do when a new `Game` object is initialized. We will want it to intialize a new `Deck` object, and two new `Participant` objects, a player and a dealer.

```ruby
class Game
  def initialize
    @deck = Deck.new
    @dealer = Participant.new('dealer')
    @player = Participant.new('player')
  end
  
  def start
    shuffle_deck
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
  
  def shuffle_deck
    @deck.shuffle_deck
  end
  
  def deal_cards
    2.times do
    	@player.hand << @deck.deal_top_card
      @dealer.hand << @deck.deal_top_card
    end
  end
  
  def show_initial_cards
    puts "Player has #{@player.hand}"
    puts "Dealer has #{@dealer.hand}"
  end
end
```

Within the `Card` class, we are going to want a way to easily display the card. We shall thus create a `display_card` method that will return a String that contains some sort of message with both the card's suit and rank. For example, `"king of diamonds"`.

```ruby
class Card < Deck
  attr_reader :suit, :rank, :value
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    if rank == 'ace'
      @value = [1, 11]
    elsif rank.to_i == 0
    	@value = 10
    else
      @value = rank.to_i
    end
  end
  
  def display_card
    "#{rank} of #{suit}"
  end
end
```

Now that we've been able to deal the cards and display the initial hand, let's think about what happens on the player's turn. The player can either 'hit' or 'stay'. Let's implement a `hit` method in the `Game` class.

```ruby
class Game
  # ....
  
	def hit(participant)
  	participant.hand << @deck.deal_top_card
	end
  
  # ...
```

Let's also define a `busted?` method within the `Participant` class.

```ruby
class Participant
  # ...
  
  def busted?
    total > 21
  end
  
  # ...
```

Also defined a `has_an_ace?` method in the `Participant` class.

```ruby
class Participant
  # ...
  
  def has_an_ace?
    hand.select { |card| card.rank == "ace" }.size > 0
  end
  
  # ...
```

Here is what I have so far....

```ruby
class Participant
  attr_reader :status
  attr_accessor :total, :hand

  def initialize(status)
    @status = status      # 'dealer' or 'player'
    @total = 0
    @hand = []            # an Array object that will contain Card objects.
  end
  
  def hit
  end
  
  def stay
  end

  def last_card
    self.hand.last
  end

  def add_card_value_to_total
    if self.last_card.is_an_ace?
      self.total += self.last_card.value.last
      self.total -= 10 if self.total > 21 
    else
      @total += @hand.last.value
    end
  end

  def busted?
    total > 21
  end
end

class Deck
  SUITS = ["clubs", "spades", "hearts", "diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]
  
  def initialize
    @deck = SUITS.map { |suit| RANKS.map { |rank| Card.new(suit, rank) } }.flatten
  end
  
  def shuffle_deck
    @deck.shuffle!
  end
  
  def deal_top_card
    @deck.pop
  end
end

class Card < Deck
  attr_reader :suit, :rank, :value
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    if rank == 'ace'
      @value = [1, 11]
    elsif rank.to_i == 0
      @value = 10
    else
      @value = rank.to_i
    end
  end
  
  def display_card
    "#{rank} of #{suit}"
  end

  def is_an_ace?
    self.rank == "ace"
  end
end

class Game
  def initialize
    @deck = Deck.new
    @dealer = Participant.new('dealer')
    @player = Participant.new('player')
  end
  
  def start
    shuffle_deck
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
  
  def shuffle_deck
    @deck.shuffle_deck
  end
  
  def deal_cards
    2.times do
      @player.hand << @deck.deal_top_card
      @player.add_card_value_to_total
      # puts @player.total.to_s
      @dealer.hand << @deck.deal_top_card
      @dealer.add_card_value_to_total
      # puts @dealer.total.to_s
    end
  end
  
  def show_initial_cards
    puts "Player has a #{@player.hand.first.display_card} and a #{@player.hand.last.display_card}."
    puts "Dealer has a #{@dealer.hand.first.display_card} and a #{@dealer.hand.last.display_card}."
  end

  def hit(participant)
    participant.hand << @deck.deal_top_card
    participant.add_card_value_to_total
  end

  def stay
    # output message saying the player decided to stay
    # move to next player
  end

  def turn(participant)
    # prompt player to 'hit' or 'stay'
    # if 'hit' then deal another card
    # if 'stay' then move to dealer's turn
  end

  def show_players_cards

  end
end

Game.new.start
```

