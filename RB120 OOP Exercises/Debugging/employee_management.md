##### RB120 - Object Oriented Programming > Debugging > Employee Management

---

## Employee Management

We have written some code for a simple employee management system. Each employee must have a unique serial number. However, when we are testing our program, an exception is raised. Fix the code so that the program works as expected without error.  

```ruby
class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  private

  attr_reader :serial_number

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca       # => Employee added.
miller_contracting << raul        # => Employee added.
miller_contracting << raul        # => Employee serial number is already in the system.
miller_contracting << natasha     # => Employee serial number is already in the system.
miller_contracting.remove(raul)   # => Employee deleted.
miller_contracting.add(natasha)   # => Employee added.

miller_contracting.display_all_employees
```

---

**Analysis of the Problem:**  

When I run the code, the first line, `miller_contracting << becca` works as expected, producing the following output:

```
Employee added.
```

However, there seems to be a problem with the next line, `miller_contracting << raul`, which raises an exception. The full output when the code is run is as follows:

```
Employee added.
employee_management.rb:58:in `==': private method `serial_number' called for #<Employee:0x00007ffad08f1da8> (NoMethodError)
	from employee_management.rb:32:in `block in exists?'
	from employee_management.rb:32:in `any?'
	from employee_management.rb:32:in `exists?'
	from employee_management.rb:12:in `add'
	from employee_management.rb:82:in `<main>'
```

From the bottom of the error message stack, we can see that the error does originate on line 82, which is the the line with `miller_contracting << raul`.  

The specific error is a `NoMethodError`, and comes with the message,

```
private method `serial_number' called for #<Employee:0x00007ffad08f1da8>
```

The problem seesm to be that within the `Employee` class, we have created a getter method for `@serial_number`, but have restricted it as a private method. Thus, when it is called from outside when trying to compare employee serial numbers with `==`, it raises an exception.

---

**My Solution:**  

We should be able to fix the problem by making the getter method for `@serial_number` a public method.  

This does solve the problem and produce the following expected output:

```
Employee added.
Employee added.
Employee serial number is already in the system.
Employee serial number is already in the system.
Employee deleted.
Employee added.
Miller Contracting Employees: 

Name: Becca
Serial No: 1932

Name: Natasha
Serial No: 4242
```

However, now that we have made `serial_number` a public method, it might make it less secure and it seems that their is some attempt at keeping serial numbers private (note that when displaying employees and their serial numbers, only the last four digits are printed to the screen).

---

**Launch School's Solution:**  

```ruby
class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  protected

  attr_reader :serial_number

  private

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end
```

###### Discussion  

Private methods cannot be invoked with an explicit caller, even inside of their own class. But on line 56, in `Employee#==`, we do invoke `serial_number` with an explicit caller (`other`).  

In order to make this work, we can make `serial_number` a _protected_ method. Recall that from outside the class, protected methods work just like private methods. From inside the class, however, protected methods are accessible and may be invoked with an explicit caller.

