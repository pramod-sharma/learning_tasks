class Array
  def power(exponent)
    map { |mantissa| mantissa ** exponent }
  end
end