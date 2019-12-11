# oo_twenty_one_my_initial_attempt.rb

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
    self.total += last_card.value

    self.hand.each do |card|
      if card.value == 11 && self.total > 21
        card.change_ace_value_to_one
        self.total -= 10
      end
    end
  end

  def busted?
    self.total > 21
  end

  def to_s
    @status.capitalize
  end
end

class Deck
  SUITS = ["Clubs", "Spades", "Hearts", "Diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
  
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
  attr_reader :suit, :rank
  attr_accessor :value
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    if rank == 'Ace'
      @value = 11
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

  def change_ace_value_to_one
    self.value = 1
  end
end

class Game
  def initialize
    @deck = Deck.new
    @dealer = Participant.new('dealer')
    @player = Participant.new('player')
  end
  
  def start
    clear
    shuffle_deck
    deal_initial_cards
    show_initial_cards
    player_turn
    if @player.busted?
      player_busted_message
    else
      dealer_turn
      show_cards(@dealer)
      if @dealer.busted?
        dealer_busted_message
      else
        display_final_results
      end
    end
  end
  
  def shuffle_deck
    @deck.shuffle_deck
  end
  
  def deal_initial_cards
    2.times do
      deal_a_card(@player)
      deal_a_card(@dealer)
    end
  end

  def deal_a_card(participant)
    participant.hand << @deck.deal_top_card
    participant.add_card_value_to_total
  end
  
  def show_initial_cards
    puts "Player has a #{@player.hand.first.display_card} and a #{@player.hand.last.display_card}."
    puts "Dealer has a #{@dealer.hand.first.display_card} and a #{@dealer.hand.last.display_card}."
    puts ""
  end

  def show_cards(participant)
    cards = participant.hand.map { |card| card.display_card }
    last_card = cards.pop
    puts "#{participant} has a #{cards.join(', ')} and a #{last_card}."
  end

  def player_turn
    loop do
      puts "Would you like to hit or stay? (h for hit or s for stay): "
      response = gets.chomp.downcase
      
      if response == 'h'
        deal_a_card(@player)
        clear
        show_cards(@player)
        break if @player.busted?
      elsif response == 's'
        break
      else
        puts "Invalid response."
      end
    end 
  end

  def dealer_turn
    while @dealer.total < 17
      puts "Dealer hits..."
      deal_a_card(@dealer)
      break if @dealer.total >= 17
      show_cards(@dealer)
      puts "Hit any key to continue."
      gets.chomp
    end
  end

  def player_busted_message
    clear
    show_cards(@player)
    puts "You have #{@player.total} points. You busted!"
    puts "Game over. You lost. The Dealer won!"
    puts ""
  end

  def dealer_busted_message
    clear
    show_cards(@dealer)
    puts "The dealer has #{@dealer.total} points. The dealer busted!"
    puts "Game over. The dealer lost. You won!"
    puts ""
  end

  def display_final_results
    show_cards(@player)
    show_cards(@dealer)
    puts "You have #{@player.total} points. The dealer has #{@dealer.total} points."
    if @player.total > @dealer.total
      puts "You won!"
    elsif @dealer.total > @player.total
      puts "The dealer won!"
    else
      puts "It's a tie!"
    end
  end

  def clear
    system 'clear'
  end
end

Game.new.start
