# stack_machine_interpretation.rb

# class Minilang
#   POP_COMMANDS = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']
#   PUSH_OR_PRINT = ['PUSH', 'PRINT']
  
#   def initialize(program)
#     @program = program.split
#     @register = 0
#     @stack = []
#   end

#   def eval
#     @program.each do |command|
#       if POP_COMMANDS.include?(command)
#         if @stack.empty?
#           puts "Empty stack!"
#           break
#         else
#           perform_operation(command)
#         end
#       elsif PUSH_OR_PRINT.include?(command)
#         perform_operation(command)
#       elsif command == command.to_i.to_s
#         @register = command.to_i
#       else
#         puts "Invalid token: #{command}"
#         break
#       end
#     end
#   end
  
#   private 

#   def perform_operation(command)
#     case command
#     when 'PUSH'
#       @stack.push(@register)
#     when 'ADD'
#       @register += @stack.pop
#     when 'SUB'
#       @register -= @stack.pop
#     when 'MULT'
#       @register *= @stack.pop
#     when 'DIV'
#       @register /= @stack.pop
#     when 'MOD'
#       @register %= @stack.pop
#     when 'POP'
#       @register = @stack.pop
#     when 'PRINT'
#       puts "#{@register}"
#     end 
#   end
# end

# Launch School's Solution:

# require 'set'

# class MinilangError < StandardError; end
# class BadTokenError < MinilangError; end
# class EmptyStackError < MinilangError; end

# class Minilang
#   ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  
#   def initialize(program)
#     @program = program
#   end
  
#   def eval
#     @stack = []
#     @register = 0
#     @program.split.each { |token| eval_token(token) }
#   rescue MinilangError => error
#     puts error.message
#   end
  
#   private
  
#   def eval_token(token)
#     if ACTIONS.include?(token)
#       send(token.downcase)
#     elsif token =~ /\A[-+]?\d+\z/
#       @register = token.to_i
#     else
#       raise BadTokenError, "Invalid token: #{token}"
#     end
#   end
  
#   def push
#     @stack.push(@register)
#   end
  
#   def pop
#     raise EmptyStackError, "Empty stack!" if @stack.empty?
#     @register = @stack.pop
#   end
  
#   def add
#     @register += pop
#   end
  
#   def div
#     @register /= pop
#   end
  
#   def mod
#     @register %= pop
#   end
  
#   def mult
#     @register *= pop
#   end
  
#   def sub
#     @register -= pop
#   end
  
#   def print
#     puts @register
#   end
# end

# Minilang.new('PRINT').eval
# Minilang.new('5 PUSH 3 MULT PRINT').eval
# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# Minilang.new('5 PUSH POP POP PRINT').eval
# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# Minilang.new('6 PUSH').eval

# Further Exploration:

# CENTIGRADE_TO_FAHRENHEIT = '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval


class Minilang
  POP_COMMANDS = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']
  PUSH_OR_PRINT = ['PUSH', 'PRINT']
  
  def initialize(program)
    @program = program
    @register = 0
    @stack = []
  end

  def eval(specs=nil)
    program = @program
    program = format(program, specs) if specs
    
    program.split.each do |command|
      if POP_COMMANDS.include?(command)
        if @stack.empty?
          puts "Empty stack!"
          break
        else
          perform_operation(command)
        end
      elsif PUSH_OR_PRINT.include?(command)
        perform_operation(command)
      elsif command == command.to_i.to_s
        @register = command.to_i
      else
        puts "Invalid token: #{command}"
        break
      end
    end
  end
  
  private 

  def perform_operation(command)
    case command
    when 'PUSH'
      @stack.push(@register)
    when 'ADD'
      @register += @stack.pop
    when 'SUB'
      @register -= @stack.pop
    when 'MULT'
      @register *= @stack.pop
    when 'DIV'
      @register /= @stack.pop
    when 'MOD'
      @register %= @stack.pop
    when 'POP'
      @register = @stack.pop
    when 'PRINT'
      puts "#{@register}"
    end 
  end
end

Minilang.new('PRINT').eval
Minilang.new('5 PUSH 3 MULT PRINT').eval
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
Minilang.new('5 PUSH POP POP PRINT').eval
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
Minilang.new('-3 PUSH 5 SUB PRINT').eval
Minilang.new('6 PUSH').eval

CENTIGRADE_TO_FAHRENHEIT = '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval

puts "------"

minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
minilang.eval(degrees_c: 0)
minilang.eval(degrees_c: -40)
minilang.eval(degrees_c: 44)

puts "------"

FAHRENHEIT_TO_CENTIGRADE = '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'

minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
minilang.eval(degrees_f: 212)
minilang.eval(degrees_f: 32)
minilang.eval(degrees_f: -40)
minilang.eval(degrees_f: 44)

puts "-------"

MPH_TO_KPH = '3 PUSH 5 PUSH %<speed_mph>d MULT DIV PRINT'

minilang = Minilang.new(MPH_TO_KPH)
minilang.eval(speed_mph: 3)
minilang.eval(speed_mph: 100)
minilang.eval(speed_mph: 50)
minilang.eval(speed_mph: 75)

puts "------"

AREA_OF_TRIANGLE = '2 PUSH %<tri_height>d PUSH %<tri_base>d MULT DIV PRINT'

minilang = Minilang.new(AREA_OF_TRIANGLE)
minilang.eval(tri_base: 4, tri_height: 8)
minilang.eval(tri_base: 9, tri_height: 6)
minilang.eval(tri_base: 23, tri_height: 14)

puts "------"

AREA_OF_RECTANGLE = '%<rect_height>d PUSH %<rect_base>d MULT PRINT'

minilang = Minilang.new(AREA_OF_RECTANGLE)
minilang.eval(rect_base: 4, rect_height: 8)
minilang.eval(rect_base: 9, rect_height: 6)
minilang.eval(rect_base: 23, rect_height: 14)



