# fix_the_program_books_pt2.rb

class Book
  attr_accessor :title, :author # added the accessor method for 2 inst. var.

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
