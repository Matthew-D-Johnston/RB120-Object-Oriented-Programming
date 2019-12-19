##### RB120 - Object Oriented Programming > Debugging > Files

---

## Files

You started writing a very basic class for handling files. However, when you begin to write some simple test code, you get a `NameError`. The error message complains of an `uninitialized constant File::FORMAT`.

```ruby
class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read, :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blot_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile         # true
puts copy_of_blog_post.read == blog_post.read     # true

puts blog_post
```

---

**Analysis of the Problem:**  

When we run the code, an exception is raised and the following message is printed to the screen:

```
true
true
files.rb:21:in `to_s': uninitialized constant File::FORMAT (NameError)
Did you mean?  Float
	from files.rb:47:in `puts'
	from files.rb:47:in `puts'
	from files.rb:47:in `<main>'
```

So the error originates on line 47 (my .rb code file) with the code `puts blog_post`. But the specific problem seems to be with the `to_s` method defined within the `File` class and its use of a reference to the `FORMAT` constant variable. The error message indicates:

```
in `to_s': uninitialized constant File::FORMAT (NameError)
```

Thus, the problem seems to be that because we have not defined `FORMAT` within our`File` class, we are referencing a variable that is unrecognizable within our `to_s` method.

---

**My Solution:**  

One solution is to prepend the reference to the `FORMAT` constant variable in the string interpolation of the `to_s` method with `self.class::`, so that `to_s` now looks like this:

```ruby
def to_s
  "#{name}.#{self.class::FORMAT}"
end
```

Another solution is to create a `to_s` method for each of our specific file classes, `MarkdownFile`, `VectorGraphicsFile`, and `MP3File`. However, the above solution is a bit more efficient.



