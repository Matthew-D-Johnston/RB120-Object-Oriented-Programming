# pet_shelter.rb

# class Pet
#   attr_reader :type_of_animal, :pet_name
  
#   def initialize(type_of_animal, pet_name)
#     @type_of_animal = type_of_animal
#     @pet_name = pet_name
#   end
# end

# class Owner
#   attr_reader :name
#   attr_accessor :number_of_pets, :pets
  
#   def initialize(name)
#     @name = name
#     @pets = []
#     @number_of_pets = 0
#   end
# end

# class Shelter
#   def initialize
#     @adoptions = {}
#   end
  
#   def adopt(owner, pet)
#     owner.pets << [pet.type_of_animal, pet.pet_name]
#     owner.number_of_pets += 1
#     @adoptions[owner] = owner.number_of_pets
#   end
  
#   def print_adoptions
#     @adoptions.keys.each do |owner|
#       puts "#{owner.name} has adopted the following pets:"
#       owner.pets.each do |pet|
#         puts "a #{pet[0]} named #{pet[1]}"
#       end
#       puts ''
#     end
#   end
# end

# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding = Pet.new('cat', 'Pudding')
# darwin = Pet.new('bearded dragon', 'Darwin')
# kennedy = Pet.new('dog', 'Kennedy')
# sweetie = Pet.new('parakeet', 'Sweetie Pie')
# molly = Pet.new('dog', 'Molly')
# chester = Pet.new('fish', 'Chester')

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')

# shelter = Shelter.new
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.print_adoptions
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# puts '-----'

# # Further Exploration:

# mjohnston = Owner.new('M Johnston')
# skippy = Pet.new('wolf', 'Skippy')
# shelter.adopt(mjohnston, skippy)
# shelter.print_adoptions

# puts "#{mjohnston.name} has #{mjohnston.number_of_pets} adopted pets."


puts '------'

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


butterscotch = Pet.new('cat', 'Butterscotch')
pudding = Pet.new('cat', 'Pudding')
darwin = Pet.new('bearded dragon', 'Darwin')
kennedy = Pet.new('dog', 'Kennedy')
sweetie = Pet.new('parakeet', 'Sweetie Pie')
molly = Pet.new('dog', 'Molly')
chester = Pet.new('fish', 'Chester')
asta = Pet.new('dog', 'Asta')
laddie = Pet.new('dog', 'Laddie')
fluffy = Pet.new('cat', 'Fluffy')
kat = Pet.new('cat', 'Kat')
ben = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
blueball = Pet.new('parakeet', 'Blueball')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.pet_intake(asta)
shelter.pet_intake(laddie)
shelter.pet_intake(fluffy)
shelter.pet_intake(kat)
shelter.pet_intake(ben)
shelter.pet_intake(chatterbox)
shelter.pet_intake(blueball)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.unadopted.length} unadopted pets."
