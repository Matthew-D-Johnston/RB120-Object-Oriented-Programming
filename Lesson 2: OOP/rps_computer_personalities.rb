# rps_computer_personalities.rb

class Rock
  attr_reader :name, :prey, :predators

  def initialize
    @name = 'rock'
    @prey = ['lizard', 'scissors']
    @predators = ['paper', 'spock']
  end
end

class Paper
  attr_reader :name, :prey, :predators

  def initialize
    @name = 'paper'
    @prey = ['rock', 'spock']
    @predators = ['scissors', 'lizard']
  end
end

class Scissors
  attr_reader :name, :prey, :predators

  def initialize
    @name = 'scissors'
    @prey = ['lizard', 'paper']
    @predators = ['rock', 'spock']
  end
end

class Lizard
  attr_reader :name, :prey, :predators

  def initialize
    @name = 'lizard'
    @prey = ['spock', 'paper']
    @predators = ['rock', 'scissors']
  end
end

class Spock
  attr_reader :name, :prey, :predators

  def initialize
    @name = 'spock'
    @prey = ['rock', 'scissors']
    @predators = ['lizard', 'paper']
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  POSSIBLE_MOVES = { rock: Rock.new, paper: Paper.new,
                     scissors: Scissors.new, lizard: Lizard.new,
                     spock: Spock.new }

  def initialize
    set_name
    @score = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.to_sym
      break if POSSIBLE_MOVES.keys.include?(choice)
      puts "Sorry, invalid choice."
    end

    self.move = POSSIBLE_MOVES[choice]
    move_history << move.name
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    case name
    when "R2D2"
      self.move = Rock.new
    when "Hal"
      self.move = [Scissors.new, Scissors.new, Scissors.new, Rock.new,
                   Lizard.new, Lizard.new, Spock.new, Spock.new].sample
    when "Chappie"
      self.move = [Rock.new, Paper.new, Scissors.new].sample
    when "Sonny"
      self.move = [Rock.new, Paper.new, Scissors.new, Lizard.new, Lizard.new,
                   Spock.new, Spock.new].sample
    when "Number 5"
      self.move = POSSIBLE_MOVES.values.sample
    end

    move_history << move.name
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move.name}."
    puts "#{computer.name} chose #{computer.move.name}."
  end

  def display_winner
    if human.move.prey.include?(computer.move.name)
      puts "#{human.name} won!"
    elsif human.move.predators.include?(computer.move.name)
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_move_history
    puts " " * 6 + human.name + " " * (20 - human.name.length) + computer.name

    1.upto(human.move_history.size) do |n|
      puts n.to_s + " " * (6 - n.to_s.length) + human.move_history[n - 1] +
           " " * (20 - (human.move_history[n - 1].length)) +
           computer.move_history[n - 1]
    end
  end

  def update_score
    if human.move.prey.include?(computer.move.name)
      human.score += 1
    elsif human.move.predators.include?(computer.move.name)
      computer.score += 1
    end
  end

  def display_score
    puts "#{human.name} has #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."
  end

  def declare_winner
    if human.score == 10
      puts "#{human.name} is the first one to 10 points and wins the game!"
    elsif computer.score == 10
      puts "#{computer.name} is the first one to 10 points and wins the game!"
    else
      puts "First one to 10 points wins."
    end
  end

  def game_over?
    human.score == 10 || computer.score == 10
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        update_score
        display_score
        declare_winner
        display_move_history
        break if game_over?
      end

      reset_score
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
