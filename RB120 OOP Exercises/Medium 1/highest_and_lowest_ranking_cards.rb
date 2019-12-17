# highest_and_lowest_ranking_cards.rb

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

# Launch School's Solution:

# class Card
#   include Comparable
#   attr_reader :rank, :suit
  
#   VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  
#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end
  
#   def to_s
#     "#{rank} of #{suit}"
#   end
  
#   def value
#     VALUES.fetch(rank, rank)
#   end
  
#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end


# Further Exploration:

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


# Examples

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

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Spades'),
         Card.new(4, 'Diamonds'),
         Card.new(4, 'Clubs'),
         Card.new(3, 'Spades')]
puts cards.min
puts cards.max