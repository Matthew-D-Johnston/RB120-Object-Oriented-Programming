# my_student.rb

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end

  protected

  attr_accessor :grade
end

joe = Student.new('joe', 80)
bob = Student.new('bob', 70)

p joe.name
puts "Well done!" if joe.better_grade_than?(bob)


