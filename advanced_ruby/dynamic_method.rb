class UserString < String
  def exclude? input
    !include? input  
  end

  def method_missing (sym, *args)
    puts "#{sym.to_s} method is missing in UserString and String class Declaration"
  end
end

puts "Enter String to initialise new object with"
user_defined_object = UserString.new gets.chomp
puts "enter method name"
method_name = gets.chomp
args_count = user_defined_object.method(method_name).arity
puts "enter #{args_count} arguments needed"
args = []
args_count.times do 
  args << gets.chomp
end 
begin
  puts user_defined_object.send method_name, *args
rescue ArgumentError
  $stderr.print "Enter correct number of arguments. #{args_count}"
end