task :alter_designations => :environment do
  Employee.all.each do |employee|
  	employee.designation = Employee::DESIGNATIONS[ employee.designation ]
	  employee.save(validate: false)
	  employee.errors.full_messages.each{ |message| puts message, employee.inspect }
	end
end