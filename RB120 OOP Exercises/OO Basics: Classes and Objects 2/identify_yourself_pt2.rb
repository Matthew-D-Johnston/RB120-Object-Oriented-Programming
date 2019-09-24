# identify_yourself_pt2.rb

# Update the following code so that it prints `I'm Sophie!` when it invokes
# `puts kitty`.

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty
