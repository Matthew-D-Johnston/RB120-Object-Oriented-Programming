## Practice Problems: Medium 1

###### Question 1  

Ben asked Alyssa to code review the following code:  

```ruby
class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance)
    @balance = starting_balance
  end
  
  def positive_balance?
    balance >= 0
  end
end
```

Alyssa glanced over the code quickly and said--"It looks fine, except that you forgot to put the `@` before `balance` when you refer to the balance instance variable in the body of the `positive_balance?` method."  

"Not so fast", Ben replied. "What I'm doing here is valid--I'm not missing an `@`!"  

Who is right, Ben or Alyssa, and why?  

**My Response:**  

Ben is right, because he has defined a getter method for balance with the line `attr_reader :balance`. Thus, in the `positive_balance?` method, `balance` invokes the getter method, which returns the instance variable `@balance`.  

**Launch School's Response:**  

Ben is right because of the fact that he added an `attr_reader` for the balance instance variable. This means that Ruby will automatically create a method called `balance` that returns the value of the `@balance` instance variable. The body of the `positive_balance?` method will evaluate to calling the `balance` method of the class, which will return the value of the `@balance` instance variable. If Ben had omitted the `attr_reader` (or had used an `attr_writer` rather than a reader or accessor) then Alyssa would be right.  

---

###### Question 2  

Alan created the following code to keep track of items for a shopping cart application he's writing:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name
  
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

Alyssa looked at the code and spotted a mistake. "This will fail when `update_quantity` is called", she says.  

Can you spot the mistake and how to address it?  

**My Response:**  

The problem is that in trying to set our `@quantity` instance variable in the `update_quantity` method we have not created a setter method for that instance variable. We have a getter method, `attr_reader`, but we will need to include a setter method, such as `attr_writer`, or we can change the getter method to `attr_accessor`. If we don't want to be able to set the `@product_name` instance variable then we will have to put it on a separate line. Or, we could simply put an `@` sign in front of `quantity` within the `update_quantity` method.

**Launch School's Response:**  

The problem is that since quantity is an instance variable, it must be accessed with the `@quantity` notation when setting it. Even though `attr_reader` is defined for quantity, the fact that it's a reader means that there is implicitly a method for retrieving the value (a "getter") but the setter is undefined. So there are two possible solutions:  

1. change `attr_reader` to `attr_accessor`, and then use the "setter" method like this: `self.quantity = updated_count if updated_count >= 0`.
2. reference the instance variable directly within the `update_quantity` method, like this `@quantity = updated_count if updated_count >= 0`.

---

###### Question 3  

In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name
  
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
```

Alyssa noticed that this will fail when `update_quantity` is called. Since quantity is an instance variable, it must be accessed with the `@quantity` notation when setting it. One way to fix this is to change `attr_reader` to `attr_accessor` and change `quantity` to `self.quantity`.  

Is there anything wrong with fixing it this way?  

**My Response:**  

Yes. The probelm with fixing it this way is that simply changing `attr_reader` to `attr_accessor` means that there is now a setter method for not just `@quantity`, but `@product_name` as well, which may be undesirable. This could be fixed by putting an `attr_reader` method on the next line and shifting `:product_name` to follow that command rather than the new `attr_accessor`.  

**Launch School's Response:**  

Nothing incorrect syntactically. However, you are altering the public interfaces of the class. In other words, you are now allowing clients of the class to change the quantity directly (calling the accessor with the `instance.quantity = <new value>` notation) rather than by going through the `update_quantity` method. It means that the protections built into the `update_quantity` method can be circumvented and potentially pose problems down the line.  

---

###### Question 4  

Let's practice creating an object hierarchy.  

Create a class called `Greeting` with a single method called `greet` that takes a string argument and prints that argument to the terminal.  

Now create two other classes that are derived from `Greeting`: one called `Hello` and one called `Goodbye`. The `Hello` class should have a `hi` method that takes no arguments and prints "Hello". The `Goodbye` class should have a `bye` method to say "Goodbye". Make use of the `Greeting` class `greet` method when implementing the `Hello` and `Goodbye` classes--do not use any `puts` in the `Hello` or `Goodbye` classes.

**My Response:**  

```ruby
class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

---

###### Question 5  

You are given the following class that has been implemented:

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end
```

And the following specification of expected behaviour:  

```ruby
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
	=> "Plain"

puts donut2
	=> "Vanilla"

puts donut3
	=> "Plain with sugar"

puts donut4
	=> "Plain with chocolate sprinkles"

puts donut5
	=> "Custard with icing"
```

**My Response:**  

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type == nil && @glazing == nil
      "Plain"
    elsif @filling_type == nil
      "Plain with #{@glazing}"
    elsif @glazing == nil
      "#{@filling_type}"
    else
      "#{@filling_type} with #{@glazing}"
    end
  end
```

**Launch School's Response:**  

We need to define the `to_s` method for the class, and then have logic that can synthesize the name based on the combinations of filling and glazing.  

```ruby
class KrispyKreme
  # ... keep existing code in place and add the below...
  def to_s
    filling_string = @filling_type ? @filling_type : "Plain"
    glazing_string = @glazing ? " with #{@glazing}" : ''
    filling_string + glazing_string
  end
end
```

Note that we can choose to create `attr_reader` directives for the filling and glazing instance variables if we want to avoid use of the `@` for accessing those instance variables and make the `to_s` easier to read.  

---

###### Question 6  

If we have these two methods:

```ruby
class Computer
  attr_accessor :template
  
  def create_template
    @template = "template 14231"
  end
  
  def show_template
    template
  end
end
```

and

```ruby
class Computer
  attr_accessor :template
  
  def create_template
    self.template = "template 14231"
  end
  
  def show_template
    self.template
  end
end
```

What is the difference in the way the code works?

**My Response:**  

There is no practical difference in how the two different bits of code work. They both accomplish the same thing.  

**Launch School's Response:**  

There's actually no difference in the result, only in the way each example accomplishes the task. Compare both `show_template` methods. We can see in the first example that it works fine without `self`, therefore, `self` isn't needed in the second example. This is because `show_template` invokes the getter method `template`, which doesn't require `self`, unlike the setter method.

---

###### Question 7  

How could you change the method name below so that the method name is more clear and less repetitive?  

```ruby
class Light
  attr_accessor :brightness, :color
  
  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end
  
  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
  
end
```

**My Response:**  

Since the method is a class method, it can only be called on the `Light` class itself. Thus, we should remove `light` from the method name `light_information`, and to make the name correspond better with the output of the method, we should change the name to `desirable_attributes`.  

**Launch School's Response:**  

Currently the method is defined as `self.light_information`, which seems reasonable. But when using or invoking the method, we would call it like this: `Light.light_information`. Having the word "light" appear twice is redundant. Therefore, we can rename the method to just `self.information`, and we can invoke it like this `Light.information`. This reads much better--remember, you're writing code to be readable by others as well as your future self.  

