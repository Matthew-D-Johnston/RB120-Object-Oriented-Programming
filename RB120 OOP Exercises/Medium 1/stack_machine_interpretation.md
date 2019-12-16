# RB120 - Object Oriented Programming

## Medium 1

### Stack Machine Interpretation  

You may remember our Minilang language from back in the RB101-RB109 Medium exercises. We return to that language now, but this time we'll be using OOP. If you need a refresher, refer back to that exercise.  

Write a class that implements a miniature stack-and-register-based programming language that has the following commands:  

* `n` Place a value n in the "register". Do not modify the stack.  
* `PUSH` Push the register value on to the stack. Leave the value in the register.
* `ADD` Pops a value from the stack and adds it to the register value, storing the result in the register.
* `SUB` Pops a value from the stack and subtracts it from the register value, storing the result in the register.
* `MULT` Pops a value from the stack and multiples it by the register value, storing the result in the register.
* `DIV` Pops a value from the stack and divides it into the register value, storing the integer result in the register.
* `MOD` Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
* `POP` Remove the topmost item from the stack and place in register.
* `PRINT` Print the register value.

All operations are integer operations (which is only important with DIV and MOD).  

Programs will be supplied to your language method via a string passed in as an argument. Your program should produce an error if an unexpected item is present in the string, or if a required stack value is not on the stack when it should be (the stack is empty). In all error cases, no further processing should be performed on the program.  

You should initialize the register to 0.  

Examples:  

```ruby
Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
#8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
```

---

**My Solution:**

```ruby
class Minilang
  POP_COMMANDS = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']
  PUSH_OR_PRINT = ['PUSH', 'PRINT']
  
  def initialize(program)
    @program = program.split
    @register = 0
    @stack = []
  end

  def eval
    @program.each do |command|
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
```

---

**Launch School's Solution:**  

###### Approach/Algorithm  

For error handling, you will likely need exceptions. See the Ruby documentation for handling exceptions and for the Exception class. You may also find this blog article on Getting Started With Ruby Exceptions helpful.  

Custom exceptions are usually derived from the `StandardError` exception class, like so:  

```ruby
class MyCustomError < StandardError; end
```

You may also find Object#send to be useful when evaluating the Minilang code.  

###### Solution

```ruby
require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  
  def initialize(program)
    @program = program
  end
  
  def eval
    @stack = []
    @register = 0
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end
  
  private
  
  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end
  
  def push
    @stack.push(@register)
  end
  
  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end
  
  def add
    @register += pop
  end
  
  def div
    @register /= pop
  end
  
  def mod
    @register %= pop
  end
  
  def mult
    @register *= pop
  end
  
  def sub
    @register -= pop
  end
  
  def print
    puts @register
  end
end 
```

---

**Further Exploration:**  

You can write minilang programs that take input values by simply interpolating values into the program string with `Kernel#format`. For instance,  

```ruby
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# 212
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# 32
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# -40
```

This process could be simplified by passing some optional parameter to eval, and using those parameters to modify the program string.

```ruby
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40
```

Try to implement this modification. Also, try writing other minilang programs, such as one that converts fahrenheit to centigrade, another that converts miles per hour to kilometres per hour (3mph is approximately equal to 5kph). Try writing a program that needs two inputs: for example, compute the area of a rectangle.  

**My Solution:**  

First thing that I will need to do for my code is to remove the call to the `split` method on the `@program` instance variable when a new `Minilang` object is initialized. I can reimplement it in with the `eval` method definition. Something like this...

```ruby
class Minilang
  POP_COMMANDS = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']
  PUSH_OR_PRINT = ['PUSH', 'PRINT']
  
  def initialize(program)
    @program = program				# removed the split method call.
    @register = 0
    @stack = []
  end

  def eval
    @program.split.each do |command|  		# reinserted the split method call here.
      if POP_COMMANDS.include?(command)
        
  # ....
```

Now, I need to modify the `eval` instance method in order to be able to pass arguments such as `degrees_c: 100`.

```ruby
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
```

That worked.  

###### FAHRENHEIT_TO_CENTIGRADE

Here is the formula:

```
(°F - 32) * 5/9 = 0*C
```

The variable part is the `°F`. Thus, our program will look something like this:

```ruby
FAHRENHEIT_TO_CENTIGRADE = '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
```

###### MPH_TO_KPH

We will use the clue given by Launch School that "3 mph is approximately equal to 5 kph", which means in our program we are going to need to take whatever input for mph that is given, multiply it by 5 and then divide by 3. This should give us a close enough approximation. Thus, our program will look something like this:

```ruby
MPH_TO_KPH = '3 PUSH 5 PUSH %<speed_mph>d MULT DIV PRINT'
```

###### AREA_OF_TRIANGLE

This will require passing a second argument to the `eval` method. But let's first think about the formula for finding the area of a triangle:

```
0.5*base*height or (base*height)/2
```

Thus, we can define the following program:

```ruby
AREA_OF_TRIANGLE = '2 PUSH %<tri_height>d PUSH %<tri_base>d MULT DIV PRINT'
```

Our `eval` method can stay the same, we just have to make sure that we explicitly pass a `Hash` object with two entries as the argument to our `specs` parameter. For example:

```ruby
AREA_OF_TRIANGLE = '2 PUSH %<tri_height>d PUSH %<tri_base>d MULT DIV PRINT'

minilang = Minilang.new(AREA_OF_TRIANGLE)
minilang.eval({tri_base: 4, tri_height: 8})
minilang.eval({tri_base: 9, tri_height: 6})
minilang.eval({tri_base: 23, tri_height: 14})
```

Although, it appears as though the curly braces `{}` are unecessary and we can simply pass the two arguments as follows:

```ruby
minilang.eval(tri_base: 4, tri_height: 8)
minilang.eval(tri_base: 9, tri_height: 6)
minilang.eval(tri_base: 23, tri_height: 14)
```

Ruby still interprets this as a single `Hash` argument.

###### AREA_OF_RECTANGLE

```ruby
AREA_OF_RECTANGLE = '%<rect_height>d PUSH %<rect_base>d MULT PRINT'

minilang.eval(rect_base: 4, rect_height: 8)
minilang.eval(rect_base: 9, rect_height: 6)
minilang.eval(rect_base: 23, rect_height: 14)
```



