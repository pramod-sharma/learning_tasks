class Interest
  attr_writer :p, :t

  def initialize
    yield self
    @r = 10
  end

  def find_amount_difference
    (find_compound_interest_amount - find_simple_interest_amount).round(2)
  end

  def find_compound_interest_amount
    @p * (1 + @r.to_f / 100) ** @t
  end

  def find_simple_interest_amount
    amount = @p * @r * @t / 100 + @p
  end
end

interest_object = Interest.new do |object|
  puts "Enter the principal"
  object.p = gets.chomp.to_i
  puts "Enter the time period"
  object.t = gets.chomp.to_i
end

print interest_object.find_amount_difference