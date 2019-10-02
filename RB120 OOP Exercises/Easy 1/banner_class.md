### Banner Class

---

**Problem:**

Behold this incomplete class for constructing boxed banners.

```ruby
class Banner
  def initialize(message)
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  def horizontal_rule
  end
  
  def empty_line
  end
  
  def message_line
    "| #{@message} |"
  end
end
```

Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.



You may assume that the input will always fit in your terminal windown.

---

**Examples / Test Cases:**

```ruby
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|																						 |
| To boldly go where no one has gone before. |
|																						 |
+--------------------------------------------+
```

```ruby
banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+
```

---

**Data Structure:**

**_Inputs_**

* A String object.

**_Outputs_**

* A print out of the string object within a border as shown above.

**_Rules_**

* To be implemented by defining a `Banner` class.
* Add whatever methods or instance variables are need.
* Make sure that the implementation details are made private.
* Assume input will always fit in the terminal windown.

---

**Algorithm:**





---

**Code:**

```ruby
class Banner
  def initialize(message)
    @message = message
    @message_length = message.length
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  attr_reader :message
  attr_reader :message_length
  
  def horizontal_rule
    '+' + '-' * (message_length + 2) + '+'
  end
  
  def empty_line
    '|' + ' ' * (message_length + 2) + '|'
  end
  
  def message_line
    "| #{@message} |"
  end
end
```

---

**Launch School's solution:**

```ruby
class Banner
  def initialize(message)
    @message = message
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  def empty_line
    "| #{' ' * (@message.size)} |"
  end
  
  def horizontal_rule
    "+-#{'-' * (@message.size)}-+"
  end
  
  def message_line
    "| #{@message} |"
  end
end
```

---

**Further Exploration:**

Modify this class so `new` will _optionally_ let you specify a fixed banner width at the time the Banner object is created. The message in the banner should be centred within the banner of that width. Decide for yourself how you want to handle widths that are either too narrow or too wide.



**Algorithm:** 

* First of all, the `banner_width` specifies the total width from the start of the banner (i.e. whether a `+` or a `|`) and the end of the banner (i.e. whether a `+` or a `|`).
* As a default for `banner_width`, we will specify a width that is 4 characters greater than the message size, as in `message.size + 4`.
* Next we need to consider three separate cases for different message lengths and different specified banner sizes: 1) if `banner_width` is 4 characters greater than the given message size, this is the neutral case and nothing special needs to be done (both the `empty_line` and `horizontal_rule` methods are defined for this case); 2) if `banner_width` is more than 4 characters greater than the given message size; and 3) if `banner_width` is less than 4 characters greater than the given message size, or just less than the total message size.
* For the first case, the condition we want to verify is `message.size + 4 == banner_width`; if this is true, then we can just do the normal case.
* For the second case, the condition we want to verify is `message.size + 4 < banner_width`; if this is the case we need to do the subtraction, `banner_width - (message.size + 4)`; if this is an even number then we can split it in two and in the message line add the result of dividing by two to either side of the message; if it is an odd number then we need to split by two and take that number and add that many spaces on the left side of the message while adding 1 to that number for the number of spaces on the right of the message.
* For the third case, the condition we want to verify is `message.size + 4 > banner_width`; we've defined the method `size_of_message_with_sides` which returns `message.size + 4`; so, we want to take `size_of_message_with_sides` and invoke the `divmod` method on it with the divisor as the `banner_width` specified; this will give us an array with the two elements: the first element is the result of division and the second is the remainder; let's name the first one `total_number_of_message_lines` and the second one `remaining_characters_in_message`
* Thus,

```ruby
total_num_of_msg_lines, remaining_chars_in_msg = size_of_msg_with_sides.divmod(banner_width - 4)
```

* From this we then want to split the message up into separate lines, where the value of `total_num_msg_lines` specifies the number of full lines that fit with in the banner width and the last line will have the message that is the length of `remaining_chars_in_msg`.
* Something like

```ruby
end_of_message = @message
messages = []
total_num_msg_lines.times do
	messages << end_of_message[0..(banner_width - 5)]
	end_of_message = end_of_message[(banner_width - 5)..-1]
end

messages.each do |msg|
  "| #{msg} |"
end
# then a line for the end_of_message 

```

or...

```ruby
message = 'To boldly go where no one has gone before.'
banner_width = 11

words = message.split # => ["To", "boldly", "go", "where", "no", "one", "has", "gone", "before."] 

loop do
  fitted_msg = ''
  
  loop do
    if words.first.size > (banner_width - 4)
      word = words.shift
      midpoint = word.size / 2
      first_half = word[0..(midpoint - 1)] + '-'
      second_half = word[midpoint..-1]
      "| #{first_half} |"
      "| #{second_half} |"
    elsif (fitted_msg + words.first).size <= (banner_width - 4) 
    	fitted_msg += words.shift + ' '
    else
      break
    end
  end

  "| #{fitted_msg.rstrip} |"
  break if words.empty?
end
```





```ruby
class Banner
  def initialize(message, banner_width=(message.size + 4))
    @message = message
    @banner_width = banner_width
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private

  def size_of_msg_with_sides
    @message.size + 4
  end
  
  def message_spacer
    (@banner_width - size_of_msg_with_sides) / 2
  end
  
  def empty_line
    "|#{' ' * (@banner_width - 2)}|"
  end
  
  def horizontal_rule
    "+#{'-' * (@banner_width - 2)}+"
  end

  def message_line
    if size_of_msg_with_sides == @banner_width
      "| #{@message} |"
    else
      if (@banner_width - size_of_msg_with_sides).even?
        "| " + (' ' * message_spacer) + "#{@message}" + (' ' * message_spacer) + " |"
      else
        "| " + (' ' * message_spacer) + "#{@message}" + (' ' * (message_spacer + 1)) + " |"
      end
    end
  end
end
```

