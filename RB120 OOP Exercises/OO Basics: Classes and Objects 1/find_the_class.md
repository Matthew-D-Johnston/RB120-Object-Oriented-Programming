### Find the Class

---

**Problem:**  

Update the following code so that , instead of printing the values, each statement prints the name of the class to which it belongs.

```ruby
puts "Hello"
puts 5
puts [1, 2, 3]
```

---

**Examples / Test Cases:**  

Expected output:

```
String
Integer
Array
```

---

**Data Structure:**

**_Inputs_**

* Any type of input.

**_Outputs_**

* Must be a string output of the class to which the input belongs.

---

**Algorithm:**

* need to redefine puts.



---

**Code:**

```ruby
def puts(input)
  p input.class
end

puts "Hello"				# => String
puts 5							# => Integer
puts [1, 2, 3]			# => Array
```

---

**Launch School's Solution:**

```ruby
puts "Hello".class
puts 5.class
puts [1, 2, 3].class
```

All values in the example are objects. Each object is an instance of a class: `"Hello"` is a `String`, `5` is an `Integer`, and `[1, 2, 3]` is an `Array`.



To find the class an object belongs to, we invoke the `#class` method.

