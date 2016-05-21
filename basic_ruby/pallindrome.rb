begin
  puts "Enter the string"
  entered_string = gets.chomp.upcase
  break if entered_string =~ /^[q]$/i
  puts "Entered string is " + ( entered_string == entered_string.reverse ? "" : "not" ) + " pallindrome"
end while true