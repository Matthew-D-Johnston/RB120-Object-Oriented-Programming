# number_guesser_pt1.rb

class GuessingGame
  RANGE = (1..100).to_a

  def play
    @remaining_guesses = 7
    @the_number = RANGE.sample
    @guess = nil

    loop do
      display_guesses_remaining
      player_guesses_a_number
      display_guess_status
      reduce_guesses_remaining
      break if game_over?
    end

    display_final_game_results
  end

  private

  def display_guesses_remaining
    puts ""
    if @remaining_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{@remaining_guesses} guesses remaining."
    end
  end

  def player_guesses_a_number
    puts "Enter a number between #{RANGE.first} and #{RANGE.last}: "
    response = nil

    loop do
      response = gets.chomp.to_i
      break if RANGE.include?(response)
      puts "Invalid guess. Enter a number between 1 and 100: "
    end

    @guess = response
  end

  def display_guess_status
    if @guess > @the_number
      puts "Your guess is too high."
    elsif @guess < @the_number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
  end

  def reduce_guesses_remaining
    @remaining_guesses -= 1
  end

  def game_over?
    @guess == @the_number || @remaining_guesses == 0
  end

  def display_final_game_results
    puts ""

    if @guess == @the_number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play
game.play

# Further Exploration

class Player
  attr_reader :remaining_guesses, :recent_guess
  
  def initialize
    @remaining_guesses = 7
    @recent_guess = nil
  end
  
  def guess
    puts "Enter a number between #{GuessingGame::RANGE.first} and #{GuessingGame::RANGE.last}: "
    response = nil

    loop do
      response = gets.chomp.to_i
      break if GuessingGame::RANGE.include?(response)
      puts "Invalid guess. Enter a number between 1 and 100: "
    end

    @recent_guess = response
    
  end
  
  def reduce_guesses_remaining
    @remaining_guesses -= 1
  end
end

class GuessingGame
  RANGE = (1..100).to_a

  def play
    @player = Player.new
    @the_number = RANGE.sample

    loop do
      display_guesses_remaining
      @player.guess
      display_guess_status
      @player.reduce_guesses_remaining
      break if @player.recent_guess == @the_number || @player.remaining_guesses == 0
    end

    display_final_game_results
  end

  private

  def display_guesses_remaining
    puts ""
    if @player.remaining_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{@player.remaining_guesses} guesses remaining."
    end
  end

  def display_guess_status
    if @player.recent_guess > @the_number
      puts "Your guess is too high."
    elsif @player.recent_guess < @the_number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
  end

  def display_final_game_results
    puts ""

    if @player.recent_guess == @the_number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play
game.play
