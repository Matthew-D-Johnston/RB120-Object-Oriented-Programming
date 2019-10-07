#complete_the_program_cats.rb

class Pet
  def initialize(name, age, fur_colour)
    @name = name
    @age = age
    @fur_colour = fur_colour
  end
end

class Cat < Pet
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur_colour} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
