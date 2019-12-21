##### RB120 - Object Oriented Programming > Debugging > Does it Rock or Not?

---

## Does it Rock or Not?

We discovered Gary Bernhardt's repository for finding out whether something rocks or not, and decided to adapt it for a simple example.

```ruby
class AuthenticationError < Exception; end

# A mock search engine
# that returns a random number instead of an actual count.

class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end
    
    rand(200_000)
  end
  
  private
  
  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'
  
  class NoScore; end
  
  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f
      
      positive / (positive + negative)
    rescue Exception
      NoScore
    end
  end
  
  def self.find_out(term)
    score = Score.for_term(term)
    
    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')           # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')            # Rain is not fun.
puts DoesItRock.find_out('Bug hunting')     # Bug hunting rocks!     
```

In order to test the case when authentication fails, we can simply set `API_KEY` to any string other than the correct key. Now, when using a wrong API key, we want our mock search engine to raise an `AuthenticationError`, and we want the `find_out` method to catch this error and print its error message `API Key is not valid.`.  

Is this what you expect to happen given the code?  

And why do we always get the following output instead?

```
Sushi rocks!
Rain rocks!
Bug hunting rocks!
```

---

**Analysis of the Problem:**

The prolem is that the program is not raising an exception when we change the `API_KEY`, say to `'LS1'` rather than the valid `'LS1A'`.

Fiddling around with Ruby pry, I realized that when the `API_KEY` was changed to an invalid key, the program was executing the line `raise AuthenticationError, 'API key is not valid.'` in the `SearchEngine` class. And when I deleted the the following lines of code from the `Score` class,

```ruby
rescue Exception
	NoScore
```

the program would raise the above authentication error and printe the message `API key is not valid.`.  

With those lines removed, and after changing the value associated with the `API_KEY` constant variable to `LS1`, we get the following:

```ruby
puts DoesItRock.find_out('Sushi')           # API key is not valid.
puts DoesItRock.find_out('Rain')            # API key is not valid.
puts DoesItRock.find_out('Bug hunting')     # API key is not valid.
```

Now, in order to get the `rescue Exception` line of code to function properly and return a `NoScore` object within the `DoesItRock#find_out` method, we need to call the `new` method on `NoScore`, rather than invoke `NoScore` on its own. Thus, we have,

```ruby
rescue Exception
	NoScore.new 		# appended `new` to the end of `NoScore`.
```

Now with this modified code, and again with our `API_KEY` constant variable set to `LS1`, we get the following,

```ruby
puts DoesItRock.find_out('Sushi')           # No idea about Sushi...
puts DoesItRock.find_out('Rain')            # No idea about Rain...
puts DoesItRock.find_out('Bug hunting')     # No idea about Bug hunting...
```

which is to be expected.

