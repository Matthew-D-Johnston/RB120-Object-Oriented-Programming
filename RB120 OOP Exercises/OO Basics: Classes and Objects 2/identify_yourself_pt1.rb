# identify_yourself_pt1.rb

# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify