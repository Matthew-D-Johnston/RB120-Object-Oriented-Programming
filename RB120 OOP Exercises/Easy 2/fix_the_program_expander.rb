# fix_the_program_expander.rb

# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     self.expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

# expander = Expander.new('xyz')
# puts expander

puts '------'

# Fixes

# Option 1:

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  protected

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

puts '------'

# Option 2:

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

