# access_denied.rb

# Modify the following code so that the value of `@phone_number` can't be
# modified outside the class.

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end

  private

  attr_writer = :phone_number

end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

puts '-----'

# LS solution:

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

# Discussion:

# When adding getters and setters, it's easy to get carried away and simply add
# `#attr_accessor` for every instance variable. However, doing this can have
# negative implications. In the initial example, `#attr_accessor` is used for
# `@phone_number`. This means that `@phone_number` can be modified from outside
# the class, which we don't want.

# We need to ensure that `@phone_number` can only be modified from within the
# class. To do this, we simply need to remove the setter method by changing
# `#attr_accessor` to `#attr_reader`. This still lets us provide a phone number
# when instantiating the object, but doesn't let us modify it from outside the
# class.


