# banner_class.rb

# class Banner
#   def initialize(message)
#     @message = message
#     @message_length = message.length
#   end
  
#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end
  
#   private
  
#   attr_reader :message
#   attr_reader :message_length
  
#   def horizontal_rule
#     '+' + '-' * (message_length + 2) + '+'
#   end
  
#   def empty_line
#     '|' + ' ' * (message_length + 2) + '|'
#   end
  
#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner

# banner = Banner.new('')
# puts banner

# puts '------'

# # LS solution:

# class Banner
#   def initialize(message)
#     @message = message
#   end
  
#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end
  
#   private
  
#   def empty_line
#     "| #{' ' * (@message.size)} |"
#   end
  
#   def horizontal_rule
#     "+-#{'-' * (@message.size)}-+"
#   end
  
#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner

# banner = Banner.new('')
# puts banner

puts '------'

# Further Exploration:

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

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner

banner = Banner.new('Hello.', 67)
puts banner
