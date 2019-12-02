# Lesson 5: Slightly Larger OO Programs

## Assignment: OO Tic Tac Toe

1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
3. Optional--when you have a better idea of the problem, modely your thoughts into CRC cards.

##### Nouns and Verbs  

Let's write a short description of the game.

```
Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns marking a square. The first player to mark 3 squares in a row wins.
```

On the surface, Tic Tac Toe is a very simple game, without too many nouns:

```
Nouns: board, player, square, grid
Verbs: play, mark
```

Let's now organize it a bit:

```
Board
Square
Player
- mark
- play
```

The "grid" noun was omitted because it's the same as a "board". There doesn't appear to be any verbs for "Board" or "Square", making the organization of verbs and nouns seem really awkward. Recall that we ran into a similar thing when first starting out the Rock, Paper, Scissors program.  

Remember, though, that this exercise only serves as a starting point for us to "spike", or explore.  

##### Spike  

Let's write our classes. We'll create an `initialize` method for the classes, and start to think about possible "states" for the objects of the class.  

```ruby
class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (i.e., 'X' or 'O')
  end
  
  def mark
    
  end
  
  def play
    
  end
end
```

Lots of questions still remain about where responsibilities lie, and how to cleanly organize the behaviours. There's still even the basic question of whether all the classes above are needed. For example, do we really need a `Square` or `Player` yet? It's not clear, and we really need to explore the problem a little to get a better feel for the code. One class we do need that we don't have just yet is some sort of orchestration engine. Let's write one.

```ruby
class TTTGame
  def play
    
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
```

Given the above, it looks like we should remove the `Player#play` method. Let's try to flesh out the sequence of the `TTTGame#play` method by invoking the methods that we wished existed.

```ruby
class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?
      
      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end
```

The above methods, if they existed and did what we expect, constitute the major steps of the Tic Tac Toe game. We have enough scaffolding code now to start exploring deeper.

