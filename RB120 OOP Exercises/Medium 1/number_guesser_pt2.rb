# number_guesser_pt2.rb

class GuessingGame

  def initialize(minimum, maximum)
    @minimum = minimum
    @maximum = maximum
    @range = @minimum..@maximum
    @remaining_guesses = nil
    @secret_number = nil
    @guess = nil
  end


  def play
    initialize_new_game

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

  def initialize_new_game
    size_of_range = @range.size
    @remaining_guesses = Math.log2(size_of_range).to_i + 1
    @secret_number = rand(@range)
  end

  def display_guesses_remaining
    puts ""
    if @remaining_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{@remaining_guesses} guesses remaining."
    end
  end

  def player_guesses_a_number
    puts "Enter a number between #{@minimum} and #{@maximum}: "
    response = nil

    loop do
      response = gets.chomp.to_i
      break if @range.cover?(response)
      puts "Invalid guess. Enter a number between 1 and 100: "
    end

    @guess = response
  end

  def display_guess_status
    if @guess > @secret_number
      puts "Your guess is too high."
    elsif @guess < @secret_number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
  end

  def reduce_guesses_remaining
    @remaining_guesses -= 1
  end

  def game_over?
    @guess == @secret_number || @remaining_guesses == 0
  end

  def display_final_game_results
    puts ""

    if @guess == @secret_number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play
game.play
