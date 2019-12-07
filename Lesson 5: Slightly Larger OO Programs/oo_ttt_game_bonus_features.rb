# oo_ttt_game_bonus_features.rb

require 'pry'

class Marker
  INITIAL_MARKER = ' '
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  CHOOSE = nil
end

class Board < Marker
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def [](key)
    @squares[key].marker
  end

  def []=(key, player_marker)
    @squares[key].marker = player_marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new(key) }
  end

  def possible_winning_square(player_marker)
    possible_winner = nil

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)

      if two_identical_markers_and_one_initial_marker?(squares, player_marker)
        possible_winner = squares.select(&:unmarked?)
      end
    end

    possible_winner ? possible_winner.first.square_key : nil
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers_and_one_initial_marker?(squares, player_marker)
    markers = squares.map(&:marker)
    markers.count(INITIAL_MARKER) == 1 && markers.count(player_marker) == 2
  end
end

class Square < Marker
  attr_accessor :marker, :square_key

  def initialize(square_key, marker=INITIAL_MARKER)
    @marker = marker
    @square_key = square_key
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def add_point
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

class TTTGame < Marker
  FIRST_TO_MOVE = CHOOSE # HUMAN_MARKER, COMPUTER_MARKER, or CHOOSE

  attr_reader :board, :human, :computer
  attr_writer :current_marker

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message

    loop do
      @current_marker = choose_first_to_move if FIRST_TO_MOVE == CHOOSE
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      display_result
      update_score
      display_score

      break unless play_again?

      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def choose_first_to_move
    puts "Choose who goes first (y for 'you' or c for 'computer'): "
    choice = nil

    loop do
      choice = gets.chomp.downcase
      break if choice == 'y' || choice == 'c'
      puts "Sorry, invalid choice. Choose y or c: "
    end

    clear
    choice == 'y' ? HUMAN_MARKER : COMPUTER_MARKER
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(unmarked, separator=", ", conj="or")
    if unmarked.size == 1
      unmarked.first.to_s
    elsif unmarked.size == 2
      "#{unmarked.first} #{conj} #{unmarked.last}"
    else
      "#{unmarked[0..-2].join(separator)}#{separator}#{conj} #{unmarked.last}"
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)})"
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_marker_assigner(board_assignment_qualifier)
    board[board_assignment_qualifier] = computer.marker
  end

  def computer_moves
    if player_about_to_win?(COMPUTER_MARKER)
      computer_marker_assigner(board.possible_winning_square(COMPUTER_MARKER))
    elsif player_about_to_win?(HUMAN_MARKER)
      computer_marker_assigner(board.possible_winning_square(HUMAN_MARKER))
    elsif square_5_available?
      computer_marker_assigner(5)
    else
      computer_marker_assigner(board.unmarked_keys.sample)
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def player_about_to_win?(player_marker)
    board.possible_winning_square(player_marker) ? true : false
  end

  def square_5_available?
    board[5] == INITIAL_MARKER
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def update_score
    case board.winning_marker
    when HUMAN_MARKER
      human.add_point
    when COMPUTER_MARKER
      computer.add_point
    end
  end

  def display_score
    puts "You have #{human.score} point(s}."
    puts "The computer has #{computer.score} point(s)."

    if human.score == 5
      puts "You have won the set!"
    elsif computer.score == 5
      puts "The computer has won the set!"
    else
      puts "The first player to five points wins the set."
    end

    puts ""
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
    puts ""
  end

  def play_again_response
    answer = nil

    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end

    answer
  end

  def play_again?
    if human.score < 5 && computer.score < 5
      puts "Continue playing? (y/n)"
    else
      puts "Woud you like to play another set? (y/n)"
    end

    play_again_response == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
    @current_marker = FIRST_TO_MOVE
    while [human.score, computer.score].include?(5)
      human.reset_score
      computer.reset_score
    end
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
