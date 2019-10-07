# rectangles_and_squares.rb

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side_lengths)
    @height = side_lengths
    @width = side_lengths
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

puts '-----'

# Launch School's solution

class Square < Rectangle
  def initialize(side_lengths)
    super(side_lengths, side_lengths)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"
