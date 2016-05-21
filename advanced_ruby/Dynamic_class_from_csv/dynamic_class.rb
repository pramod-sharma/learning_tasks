require 'csv'
class ClassCreator
	def self.create_class( class_name, csv_obj )
		new_class = Class.new do
			def initialize args
				args.each do | key, value |
					self.instance_variable_set( "@#{ key }", value )
				end
			end

			csv_obj.fields.each do |field|
				(class << self; self; end).instance_eval do
					define_method ( field ) do
						ObjectSpace.each_object( self ).collect{ | object | object.instance_variable_get( "@#{ field }" ) }
					end
				end
			end

		end
		Object.const_set class_name, new_class
	end
end

def generate_class_name file_name
	file_name.gsub(/[[:punct:]]/,'').capitalize
end

objects_array = []
begin
	puts "Enter CSV file path"
	file_path = gets.chomp
	file_name = File.basename(file_path, ".csv")
	raise "Input file not CSV. Enter a file with .csv extension" if File.extname(file_path) != ".csv"
	class_name = generate_class_name file_name
	CSV.foreach('source_details.csv', :headers => true, :return_headers => true) do |csv_obj|
		if csv_obj.header_row?
			ClassCreator.create_class class_name, csv_obj
		else
			objects_array.push (Object::const_get(class_name).new csv_obj).inspect
		end
	end
rescue Errno::ENOENT
	puts "File Not Found"
	retry
rescue => exception
  puts exception
  retry
end
puts objects_array
Object.send :remove_const, class_name