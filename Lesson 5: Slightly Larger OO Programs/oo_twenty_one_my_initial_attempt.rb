# oo_twenty_one_my_initial.rb


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
