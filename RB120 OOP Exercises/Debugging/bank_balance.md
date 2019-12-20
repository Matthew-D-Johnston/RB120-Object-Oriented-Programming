##### RB120 - Object Oriented Programming > Debugging > Bank Balance

---

## Bank Balance

We created a simple `BankAccount` class with overdraft protection, that does not allow a withdrawal greater than the amount of the current balance. We wrote some example code to test our program. However, we are surprised by what we see when we test its behaviour. Why are we seeing this unexpected output? Make changes to the code so that we see the appropriate behaviour.  

```ruby
class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50
```

---

**Analysis of the Problem:**  

When the code is run, we get the folloing print out to the screen:

```
0
"$50 deposited. Total balance is $50."
50
"$80 withdrawn. Total balance is $50."
50
```

Everything is as expected except for the fourth line of the output. We were expecting, `Invalid. Enter positive amount less than or equal to current balance ($50).`  Instead, we got, `"$80 withdrawn. Total balance is $50."` While we didn't get the message we were looking for, the withdrawal did not actually happen since the balance is still $50. That is the one positive fact, but we need to think about why the expected message did not appear.

Using `pry`, and inserting a `binding.pry` in the `withdraw` method...

```ruby
  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
      binding.pry
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end
```

What we find is that while `success = -30`, and will thus evalutate to `true` in the `if/then` conditional statement at the bottom of the `withdraw` method, `balance` is not `-30`, but `50`. What we are expecting, however, is that the return value of `(self.balance -= amount)` will be `false`.  

Let's try inserting a `binding.pry` in our `valid_transaction?` method:

```ruby
  def valid_transaction?(new_balance)
    new_balance >= 0
    binding.pry
  end
```

Here we see that the argument that is passed to the `new_balance` parameter is `50`, when what we are expecting is `-30`. This means that the transaction will be deemed valid, and it also suggests that the argument being passed to the `new_balance` parameter through the `balance=` setter method is also `50`, when we are expecting it to be `-30`.

Let's just insert a `binding.pry` inside the `balance=` method to make sure:

```ruby
  def balance=(new_balance)
    binding.pry
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end
```

Actually, the `new_balance` parameter is equal to `-30` here. That means that `-30` is being passed in as an argument and that `valid_transaction?` is returning `false`, but that for some reason the setter method `balance=` is not returning false so that we can obtain get `success = false` instead the `success = -30` that we are getting.  

My hunch is that somehow the `self.balance -= amount` operation is allowed to occur in the sense that the return value of that operation is allowed to be `-30`, but our setter method is such that it won't allow `@balance` to be set to a negative number and so it remains at `50`. Thus, `success` is assigned to the return value of the `self.balance -= amount` operation but `@balance` is not affected since we are dealing with a negative amount.  

**My Solution:**  

A quick solution to this problem is to insert a line after `success = (self.balance -= amount)`:

```ruby
  def withdraw(amount)
    if amount > 0
      (self.balance -= amount) < 0 ? success = false : success = true
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end
```

This ensures that `success` will have a return value of `false` if `success < 0`. This might not be the best solution since we still have the complicated line of code `self.balance -= amount`, which is doing two separate things: 1) it is returning a value based on the operation of `-=` but it is also determining whether or not to change `@balance`. In the case where the new balance would be negative, `@balance` is not change, but in the case where the new balance would be positive, `@balance` will be updated. However, the ternary line of code `(self.balance -= amount) < 0 ? success = false : success = true` makes it appear as if all we are doing is evaluating whether the return value of `(self.balance -= amount)` is positive or negative.

---

**Launch School's Solution:**  

```ruby
class BankAccount
  # code omitted
  
  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end
  
  def balance=(new_balance)
    @balance = new_balance
  end
  
  # code omitted
end
```

###### Dicussion  

In Ruby, setter methods _always_ return the argument that was passed in, even when you add an explicit `return` statement. Our `balance=` method will therefore always return its argument, irrespective of whether or not the instance variable `@balance` is re-assigned.  

Because of this behaviour, the invocation of `balance=` on line 21 of the original code will have a truthy return value even when our setter method does not re-assign `@balance`; it will never return `false`.  

A better solution is to check the validity of the transaction by calling `valid_transaction?` in `withdraw` instead of `balance=`. If the transaction is deemd valid, we then invoke `balance=`, otherwise we don't. This way we don't attempt to use the setter for its return value, but instead let it do its one job: assigning a value to `@balance`.  

---

**Further Exploration:**  

What will the return value of a setter method be if you mutate its argument in the method body?  

**My Response:**  

The return value will still be the value that was originally passed to the method.