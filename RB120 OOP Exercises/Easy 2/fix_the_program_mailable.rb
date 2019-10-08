# fix_the_program_mailable.rb

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable      # added this line

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable      # added this line

  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new
bob = Employee.new
betty.print_address
bob.print_address
