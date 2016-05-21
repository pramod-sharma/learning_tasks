def modify_search_result(search_variable)
  puts "Enter the string"
  entered_string, occurence_count = gets.chomp, 0
  modified_string = entered_string.gsub(/#{search_variable}/) { occurence_count += 1; "(#{search_variable})" }
  return modified_string,occurence_count
end