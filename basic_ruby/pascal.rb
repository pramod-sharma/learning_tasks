def pascal(max_index)
  for index in 1..(max_index + 1)
    yield index
    puts ""
  end
end
pascal(6) do |max_index|
  pascal_variable = 1
  for index in 1..max_index 
    print pascal_variable.to_s + " " 
    pascal_variable = pascal_variable * (max_index - index) / index
  end
end 