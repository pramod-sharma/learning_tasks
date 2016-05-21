class Name
  def initialize first_name, last_name
    begin
      raise "First-Name can't be blank" if first_name.strip == '' 
      raise "Last-Name can't be blank" if last_name.strip == ''
      raise "First Name's first letter must be capital" if !(first_name =~ /^[A-Z]{1}/)
      @first_name = first_name
      @last_name = last_name
    rescue
      $stderr.print $!
    end
  end
end