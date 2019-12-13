# students.rb

# Original Code:

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate
#   def initialize(name, year, parking)
#   end
# end

# class Undergraduate
#   def initialize(name, year)
#   end
# end

# Only change five lines of code:

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate < Student                # change 1
#   def initialize(name, year, parking)
#     super(name, year)                   # change 2
#     @parking = parking                  # change 3
#   end
# end

# class Undergraduate < Student           # change 4
#   def initialize(name, year)
#     super                               # change 5
#   end
# end

# p Student.new("Sue", 2002)
# p Undergraduate.new("Bill", 2001)
# p Graduate.new("Matt", 2000, true)

# Further Exploration:

class StudentBody
  @@total_students = 0

  def initialize
    @@total_students += 1
    @student_number = @@total_students
  end
end

class Student < StudentBody
  def initialize(name, year)
    @name = name
    @year = year
    super()
  end
end

class Graduate < Student                # change 1
  def initialize(name, year, parking)
    super(name, year)                   # change 2
    @parking = parking                  # change 3
  end
end

class Undergraduate < Student           # change 4
  def initialize(name, year)
    super                               # change 5
  end
end

p Student.new("Sue", 2002)
p Undergraduate.new("Bill", 2001)
p Graduate.new("Matt", 2000, true)
