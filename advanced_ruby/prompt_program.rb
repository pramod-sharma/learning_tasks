class MethodCreator

  def self.create_method method_name, code_entered

    class_eval %{
      def #{method_name}
        #{code_entered}
      end
    }
    
  end
end

puts "Enter the name of function"
method_name = gets.chomp
puts "Enter a single line code"
code_entered = gets.chomp

MethodCreator.create_method method_name, code_entered
method_creator = MethodCreator.new
method_creator.send( method_name)