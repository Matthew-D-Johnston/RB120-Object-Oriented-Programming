# deck_of_cards.rb

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
    rank_value = assign_numerical_rank(rank)
    other_value = assign_numerical_rank(other.rank)

    rank_value <=> other_value
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

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @full_deck = generate_new_deck
  end

  def draw
    @full_deck = generate_new_deck if @full_deck.empty?
    @full_deck.shuffle!.pop
  end

  private
  
  def generate_new_deck
    SUITS.map{ |suit| RANKS.map { |rank| Card.new(rank, suit) } }.flatten
  end
end 

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2
