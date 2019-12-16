# RB120 - Object Oriented Programming

## Medium 1

### Number Guesser Part 2  

In the previous exercise, you wrote a number guessing game that determines a secret number between 1 and 100, and gives the user 7 opportunities to guess the number.  

Update your solution to accept a low and high value when you create a `GuessingGame` object, and use those values to compute a secret number for the game. You should also change the number of guesses allowed so the user can always win if she uses a good strategy. You can computer the number of guesses with:

```ruby
Math.log2(size_of_range).to_i + 1
```

Examples:

```ruby
game = GuessingGame.new(501, 1500)
game.play

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
That's the number!

You won!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low.

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low.

You have no more guesses. You lost!
```

Note that a game object should start a new game with a new number to guess with each call to `#play`.  

---

**My Solution:**

```ruby
class GuessingGame

  def initialize(minimum, maximum)
    @minimum = minimum
    @maximum = maximum
    @range = @minimum..@maximum
  end


  def play
    size_of_range = @range.size
    @remaining_guesses = Math.log2(size_of_range).to_i + 1
    @secret_number = rand(@range)
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
```



