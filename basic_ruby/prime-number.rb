def generate_prime_number(max_number)
  prime_number_array = []
  if max_number >= 2
    prime_number_array = [2]
    (3..max_number).step(2) do |value|
      prime_number_array.push value
      (2..Math.sqrt(value).ceil).any? { |divisor| prime_number_array.pop if value % divisor == 0 }
    end
  end
  prime_number_array
end