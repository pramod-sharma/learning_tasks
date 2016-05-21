animal = String.new "Cat"

def animal.invert_case
  swapcase
end

second_animal = "New Cat"

second_animal.instance_eval do
  class << self
    def reverse_case
      swapcase
    end
  end
end
puts animal.invert_case
puts second_animal.reverse_case

#The below output will show public and protected singleton methods of animal and second_animal
puts "animal instance singleton methods : #{animal.methods(regular = false)}"
puts "second_animal instance singleton methods : #{second_animal.methods(regular = false)}"