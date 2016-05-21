class Fixnum 
  def generate_roman_string ( roman_string, divisor, remainder, quotient )
    roman_literals = {1 => "I", 5 => "V", 10 => "X", 50 => "L", 100 => "C", 500 => "D", 1000 => "M"}
    operation_complete_status = false
    roman_string += roman_literals[divisor] * quotient
    roman_literals.each do |key, value|
      if remainder + key == divisor && remainder != 0 && key < remainder
        roman_string += value + roman_literals[divisor]
        operation_complete_status = true 
        break
      end
    end
    return roman_string, operation_complete_status
  end
  def to_roman
    roman_literals = {1 => "I", 5 => "V", 10 => "X", 50 => "L", 100 => "C", 500 => "D", 1000 => "M"}
    roman_string, divisor, remainder, quotient = "", 1000, self, 0
    operation_complete_status = false
    while divisor > 0
      quotient, remainder = remainder/divisor, remainder % divisor
      roman_string, operation_complete_status = generate_roman_string( roman_string, divisor, remainder, quotient )
      divisor /= 2
      return roman_string if operation_complete_status == true || divisor == 0

      quotient, remainder = remainder / divisor, remainder % divisor
      roman_string, operation_complete_status = generate_roman_string( roman_string, divisor, remainder, quotient )
      return roman_string if operation_complete_status == true
      divisor /= 5
    end
    return roman_string
  end
end
(1..400).each do |value|
  puts value.to_s + "   " + value.to_roman
end