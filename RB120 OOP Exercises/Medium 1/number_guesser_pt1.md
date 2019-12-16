# RB120 - Object Oriented Programming

## Medium 1

### Number Guesser Part 1  

Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:  

```ruby
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.
  
You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
```

Note that a game object should start a new game with a new number to guess with each call to `#play`.  

---

**Data Structure:**

* Create a class, `GuessingGame`.
* Create an instance of that class, `game = GuessingGame.new`.
* When `play` instance method is invoked on `game`, the user will be required to input an `Integer` object.
* Outputs include various messages (`String` objeccts).

---

**Algorithm:**  

* First create the class.
* Create a constant variable indicating the acceptable range of numbers: `RANGE = (1..100).to_a`.
* Define an `initialize` method that will initialize the following instance variables whenever a new object of the class is created: 1) `@remaining_guesses = 7`, and 2) `@the_number = RANGE.sample`.
* Here is a simple outline of what the `play` method should do:
  * Display message telling player how many guesses the have remaining: `display_guesses_remaining`.
  * Prompt player to guess a number: `guess_a_number`.
  * Indicate with the guess was too high, too low, or the winning number: `display_guess_result`.
  * Reduce number of guesses by one if the player didn't guess the correct number: `reduce_remaining_guesses`.
  * Display whether or not the player won or lost: `display_game_results`.

---

**Code:**  

```ruby
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
      break if @guess == @the_number || @remaining_guesses == 0
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

  def display_final_game_results
    puts ""

    if @guess == @the_number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end
```

---

**Launch School's Solution:**  

```ruby
class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100
  
  RESULT_OF_GUESS_MESSAGE = {
    high: "Your number is too high.",
    low: "Your number is too low.",
    match: "That's the number!"
    }.freeze
  
  WIN_OR_LOSE = {
    high: :lose,
    low: :lose,
    match: :win
    }.freeze
  
  RESULT_OF_GAME_MESSAGE = {
    win: "You won!",
    lose: "You have no more guesses. You lost!"
    }.freeze
  
  def initialize
    @secret_number = nil
  end
  
  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end
  
  private
  
  def reset
    @secret_number = rand(RANGE)
  end
  
  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(otain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end
  
  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts 'You have #{remaining} guesses remaining.'
    end
  end
  
  def obain_one_guess
    loop do
      print "Enter a number between #{Range.first} and #{Range.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end
  
  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end
  
  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end
```

---

**Further Exploration:**  

We took a straightforward approach here and implemented a single class. Do you think it's a good idea to have a Player class? What methods and data should be part of it? How many Player objects do you need? Should you use inheritance, a mix-in module, or a collaborative object?  

**My Solution:**

If we were to create a separate `Player` class, we could use it to store the player's remaining guesses and perhaps even the player's most recent guess. We could even make it so that we can keep track of all of the player's guesses and only use the most recent one for the current game implementation. But, we won't do that for now since it is not required.  

As for behaviours, we could have a `guess` method, which would prompt the user to guess a number and store the result in the player's `@recent_guess` instance variable. Also, the `reduce_guesses_remaining` instance method could be transferred to the `Player` class.

```ruby
class Player
  attr_reader :guesses_remaining, :recent_guess
  
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
```

With this new `Player` class, we will modify our `GuessingGame` class by treating `Player` as a collaborator. That means that, within the `GuessingGame` class we will be creating a new `Player` object.

```ruby
class GuessingGame
  RANGE = (1..100).to_a

  def play
    @player = Player.new
    @the_number = RANGE.sample

    loop do
      display_guesses_remaining
      player_guesses_a_number
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
```









