### Pet Shelter

---

**Problem:**  

Consider the following code:

```ruby
butterscotch = Pet.new('cat', 'Butterscotch')
pudding = Pet.new('cat', 'Pudding')
darwin = Pet.new('bearded dragon', 'Darwin')
kennedy = Pet.new('dog', 'Kennedy')
sweetie = Pet.new('parakeet', 'Sweetie Pie')
molly = Pet.new('dog', 'Molly')
chester = Pet.new ('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
```

Write the classes and methods that will be necessary to make this code run, and print the following output:

```
P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
```

---

**Data Structure:**  

* Define three new classes: `Pet`, `Owner`, and `Shelter`.
* A new `Pet` object is initialized with two string arguments passed into the `new` method: 1) a string specifying the type of animal; and 2) a string representing the pet's name.
* A new `Owner` object is initialized with one string argument passed into the new method: a string representing the owner's first initial and last name.
* A new `Shelter` object is initialized without any arguments passed to the `new` method.

---

**Algorithm:**  

* `Pet` class:
  * Needs both a `@type_of_animal` and a `@pet_name` instance variable; both of which should be accessible to be read outside of the class itself.
* `Owner` class:
  * Needs a `@name` instance variable that is accessible to be read outside of the class itself.
  * Also needs an `@pets` variable accessible to be read and written, and which is an array that will contain nested arrays with the first element of each nested array containing the type of  animal and the second element of the nested array containing the pet's name.
  * Also needs a `@number_of_pets` instance variable that keeps track of the number of pets the owner has, and is accessible to be read and written.
* `Shelter` class:
  * Not initialized with any input.
  * Initialize with an `@adoptions` instance variable, which begins as an empty array.
  * Need to create an `adopt` instance method that takes an `Owner` object and a `Pet` object as arguments; the method should take the `Owner` object passed to it and add the attributes of the `Pet` object (i.e. `@type_of_animal` and `@pet_name`) to the `@pets` variable of the `Owner` object. They should be added as a nested array.
  * Nees a `print_adoptions` method that prints out the owner's name 



---

**Code:**

```ruby
class Pet
  attr_reader :type_of_animal, :pet_name
  
  def initialize(type_of_animal, pet_name)
    @type_of_animal = type_of_animal
    @pet_name = pet_name
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets, :pets
  
  def initialize(name)
    @name = name
    @pets = {}
    @number_of_pets = 0
  end
end

class Shelter
  def initialize
    @adoptions = {}
  end
  
  def adopt(owner, pet)
    owner.pets << [pet.type_of_animal, pet.pet_name]
    owner.number_of_pets += 1
    @adoptions[owner] = owner.number_of_pets
  end
  
  def print_adoptions
    @adoptions.keys.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet[0]} named #{pet[1]}"
      end
      puts ''
    end
  end
end
```

---

**Launch School's Solution:**

```ruby
class Pet
  attr_reader :animal, :name
  
  def initialize(animal, name)
    @animal = animal
    @name = name
  end
  
  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def add_pet(pet)
    @pets << pet
  end
  
  def number_of_pets
    pets.size
  end
  
  def print_pets
    puts pets
  end
end

class Shelter
  def initialize
    @owners = {}
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end
  
  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end
```

---

**Further Exploration:**  

Add your own name and pets to this project.

```ruby
mjohnston = Owner.new('M Johnston')
skippy = Pet.new ('wolf', 'Skippy')
shelter.adopt(mjohnston, skippy)
shelter.print_adoptions

puts "#{mjohnston.name} has #{mjohnston.number_of_pets} adopted pets."
```

---

Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:

```
The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
	...

P Hanson has 3 adopted pets.
```

Code:

```ruby
class Pet
  attr_reader :animal, :name
  
  def initialize(animal, name)
    @animal = animal
    @name = name
  end
  
  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def add_pet(pet)
    @pets << pet
  end
  
  def number_of_pets
    pets.size
  end
  
  def print_pets
    puts pets
  end
end

class Shelter
  attr_reader :unadopted
  
  def initialize
    @owners = {}
    @unadopted = []
  end
  
  def pet_intake(pet)
    @unadopted << [pet]
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end
  
  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
    
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted.each do |pet|
      puts pet
    end
    puts
  end
end

...
  
puts "The Animal shelter has #{shelter.unadopted.length} unadopted pets."
```



