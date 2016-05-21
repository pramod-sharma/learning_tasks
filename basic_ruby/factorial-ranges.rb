def factorial(max_index)
  return (1..max_index).inject(1) {|factorial, value| factorial * value}
end