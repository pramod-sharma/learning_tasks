class Program
  def execute code
    instance_eval code
  end 
end

#Ask for user input and store input
code = ""
loop do
  case gets
  when "\n"
    break
  when /^[q]\n/i
    exit
  else
    code += $_
  end
end 

new_program = Program.new
new_program.execute code