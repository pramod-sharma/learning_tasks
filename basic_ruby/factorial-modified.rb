def factorial(max_index)
  begin
    raise "Enter a valid value. Negative values are not acceptable" if max_index < 0
    return (2..max_index).inject(1) { |factorial, value| factorial * value }
  rescue
    return $!
  end
end