emp_details_hash = Hash.new([])

IO.foreach("source_details.txt") do |line| 
  emp_name, emp_id, emp_designation = line.chomp.split(',')
  # Enter new hash for each employee in array of corresponding designation
  emp_details_hash[emp_designation] += ["#{emp_name} (EmpId: #{emp_id})"] 
end

File.open("details_group_by_designation.txt", "w") do |file|
  emp_details_hash.each do |key,emp_details_array|
    file.puts "#{key} :"
    file.puts emp_details_array
      # output each employees name and id  present within corresponding emp_designation key hash 
  end
end