# oo_twenty_one_my_initial_attempt.rb

class Participant
  attr_reader :status
  attr_accessor :total, :hand

  def initialize(status)
    @status = status      # 'dealer' or 'player'
    @total = 0
    @hand = []            # an Array object that will contain Card objects.
  end

  def last_card
    hand.last
  end

  def add_card_value_to_total
    self.total += last_card.value

    hand.each do |card|
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
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10",
           "Jack", "Queen", "King", "Ace"]

  def initialize
    @deck = SUITS.map { |suit| RANKS.map { |rank| Card.new(suit, rank) } }
                 .flatten
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
    @value = if rank == 'Ace'
               11
             elsif rank.to_i == 0
               10
             else
               rank.to_i
             end
  end

  def display_card
    "#{rank} of #{suit}"
  end

  def change_ace_value_to_one
    self.value = 1
  end
end

class Game
  attr_accessor :deck

  def initialize
    @deck = Deck.new
    @dealer = Participant.new('dealer')
    @player = Participant.new('player')
  end

  def start
    display_welcome_message

    loop do
      initialize_game
      player_turn
      if @player.busted?
        player_busted_message
      else
        dealer_turn
        if @dealer.busted?
          dealer_busted_message
        else
          display_final_results
        end
      end

      break unless play_again?
      reset_game
      clear
    end

    display_goodbye_message
  end

  def display_welcome_message
    clear
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One! Goodbye."
  end

  def initialize_game
    shuffle_deck
    deal_initial_cards
    show_initial_cards
  end

  def play_again?
    puts ""
    puts "Would you like to play again? (y/n): "
    response = nil

    loop do
      response = gets.chomp.downcase
      break if response == 'y' || response == 'n'
      puts "Invalid response. Choose y or n: "
    end

    response == 'y'
  end

  def shuffle_deck
    puts "Dealer is shuffling deck..."
    sleep 2
    puts "..."
    sleep 1.5
    @deck.shuffle_deck
  end

  def deal_initial_cards
    puts "Dealer is dealing the cards..."
    sleep 2
    puts "..."
    sleep 2
    puts ""
    2.times do
      deal_a_card(@player)
      deal_a_card(@dealer)
    end
  end

  def deal_a_card(participant, message=false)
    participant.hand << @deck.deal_top_card
    participant.add_card_value_to_total

    dealing_card_message(participant) if message
  end

  def dealing_card_message(participant)
    puts "Dealer is dealing a card..."
    sleep 2
    puts "Dealer has dealt a #{participant.hand.last.display_card}."
    sleep 1.5
    puts ""
  end

  def show_initial_cards
    show_cards(@player)
    show_cards(@dealer)
    puts ""
  end

  def show_cards(participant)
    cards = participant.hand.map(&:display_card)
    first_card = cards.shift
    last_card = cards.pop

    case participant
    when @player
      display_player_cards_message(cards, first_card, last_card)
    when @dealer
      display_dealer_cards_message(cards, last_card)
    end
  end

  def reveal_dealers_full_hand
    cards = @dealer.hand.map(&:display_card)
    last_card = cards.pop

    puts "Dealer has a #{cards.join(', ')} and a #{last_card}."
  end

  def display_player_cards_message(cards, first_card, last_card)
    if cards.empty?
      puts "You have a #{first_card} and a #{last_card}."
    else
      puts "You have a #{first_card}, a #{cards.join(', ')} and a #{last_card}."
    end
  end

  def display_dealer_cards_message(cards, last_card)
    if cards.empty?
      puts "Dealer has an unknown card and a #{last_card}."
    else
      puts "Dealer has an unknown card, a #{cards.join(', ')} and a #{last_card}."
    end
  end

  def player_turn
    puts "Would you like to hit or stay? (h for hit or s for stay): "
    response = nil

    loop do
      response = gets.chomp.downcase

      if response == 'h'
        clear
        deal_a_card(@player, true)
        show_cards(@player)
        show_cards(@dealer)
        puts ""
        break if @player.busted?
        puts "Would you like to hit or stay? (h for hit or s for stay): "
      elsif response == 's'
        clear
        puts ""
        break
      else
        puts "Invalid response. Choose h or s: "
      end
    end
  end

  def dealer_turn
    while @dealer.total < 17
      puts "Dealer hits."
      deal_a_card(@dealer, true)
      show_cards(@player)
      show_cards(@dealer)
      sleep 4
      puts ""
      break if @dealer.total >= 17
    end
  end

  def player_busted_message
    sleep 1.5
    puts "You have #{@player.total} points. You busted!"
    puts "Game over. You lost. The Dealer won!"
    puts ""
  end

  def dealer_busted_message
    sleep 1.5
    reveal_dealers_full_hand
    puts "The dealer has #{@dealer.total} points. The dealer busted!"
    puts "Game over. The dealer lost. You won!"
    puts ""
  end

  def display_final_results
    puts "Dealer stays."
    sleep 1.5
    clear
    show_cards(@player)
    reveal_dealers_full_hand
    puts ""
    puts "You have #{@player.total} points. The dealer has #{@dealer.total} points."
    sleep 1.5
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

  def reset_game
    @player.hand = []
    @dealer.hand = []
    @player.total = 0
    @dealer.total = 0
    @deck = Deck.new
  end
end

Game.new.start
