# poker.rb

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

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
# puts "------"
# puts hand.number_of_identical_ranks(2)
# puts hand.number_of_identical_ranks(3)
# puts hand.number_of_identical_ranks(4)
# puts "------"
# puts hand.pair?
# puts hand.two_pair?
# puts hand.three_of_a_kind?
# puts hand.four_of_a_kind?
# puts hand.full_house?

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
