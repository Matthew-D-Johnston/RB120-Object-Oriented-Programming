# generic_greeting_pt1.rb

# Modify the following code so that `Hello! I'm a cat!` is printed when
# `Cat.generic_greeting` is invoked.

# class Cat
# end

# Cat.generic_greeting

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# Further Exploration:
# What happens if you run `kitty.class.generic_greeting`? Can you explain this
# result?

kitty = Cat.new
kitty.class.generic_greeting

# In the above case, the `class` method is invoked on `kitty` an instance of
# the `Cat` class. Since the `class` method returns the class of the object on
# which it is invoked, the `Cat` class will be returned and receives the
# `generic_greeting` method call. Since the `generic_greeting` method is a
# class method defined within the `Cat` class, it will be executed, printing
# out the expected `Hello! I'm a cat!` string.
