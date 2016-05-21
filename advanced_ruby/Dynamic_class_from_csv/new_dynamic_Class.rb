require 'csv'
class ClassCreator
  def self.create_class( class_name, csv_fields )
    new_class = Class.new do
      @@list = []
      #puts instance_variables
      #send :attr_reader, *instance_variables
      def initialize args
        index = 0
        puts args
        #iterates through all the instance variables declared at the time
        #of class creation and sets 
        self.class.instance_variables.each do |instance_variable|

          #To set instance_variable as per new object values 
          self.class.instance_variable_set( "#{ instance_variable}", args[ index ] )
          
          #To get value of class_variable i.e. returns array
          class_variable_array = self.class.class_variable_get( "@#{ instance_variable }" )
          
          #To push new args value into class variable
          self.class.class_variable_set( "@#{ instance_variable }", class_variable_array.push( "#{ args[ index ] }" ) ) 
          index += 1
        end
        puts self.is_a? Sourcedetails
      end


      def self.list
        @@list
      end


      #Iterates over fields of header row in CSV file
      csv_fields.each do |field|
        field.delete!(' ')

        #Initialises class with necessary class and instance variables
        class_eval do
          instance_variable_set( "@#{ field }", '' )
          class_variable_set( "@@#{ field }", [] )
        end
        self.class.instance_eval do
          #Create class methods which in turn returns value of a 
          #particular field
          define_method ( field ) do 
            class_variable_get( "@@#{ field }" )
          end
        end
      end

    end
    Object.const_set class_name, new_class
  end
end

def new_class_name file_name
  file_name.gsub(/[[:punct:]]/,'').capitalize
end


begin
  puts "Enter CSV file path"
  file_path = gets.chomp
  file_name = File.basename(file_path, ".csv")
  class_name = new_class_name file_name
  raise "Input file not CSV. Enter a file with .csv extension" if File.extname(file_path) != ".csv"
  csv_contents = CSV.read(file_path)
  ClassCreator.create_class class_name, csv_contents.shift #initialises method with header row

  #initialises objects with csv data
  new_objects_array = csv_contents.collect do |row|
    (Object::const_get(class_name).new row).inspect
  end
rescue Errno::ENOENT
  puts "File Not Found"
  retry
rescue => Exception
  puts Exception
  retry
end

puts new_objects_array
puts Sourcedetails.class_variables
#puts new_objects_array
#Object::const_get(class_name).list.each do |object|
#  object.John
#end
puts Sourcedetails.list
puts Sourcedetails.name
Object.send :remove_const, class_name