class Calculator
  def calculate operand1, operator, operand2
    output = operand1.send(operator, operand2)
  end
end
calc = Calculator.new
print calc.calculate 12, :+, 23