# hello_sophie_pt1.rb

class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{name}!" # or @name, as LS does in their solution.
  end
end

kitty = Cat.new('Sophie')
