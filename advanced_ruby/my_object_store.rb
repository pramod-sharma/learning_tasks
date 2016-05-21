$user_array = []
$validation_list = []

class Class
  alias original_attr_accessor attr_accessor

  def attr_accessor( *variables_defined )
    variables_defined.each do |variable|
      ( class << Play; self; end ).class_eval do

        define_method( "find_by_#{ variable.to_s }" ) do | variable_value |
          $user_array.select do | object |
            object.instance_variable_get( "@#{ variable.to_s }" ) == variable_value
          end
        end

      end
      send(:original_attr_accessor, variable)
    end
  end

end

module MyObjectStore

  def self.included class_including

    class<< class_including
      def validate_presence_of *variables_arr
        variables_arr.each do | variable |
          $validation_list.push variable.to_s
        end
      end
    end

    def save
      $user_array.push self 
      if defined? validate()
        if validate()
          $user_array.pop
        end
      end
    end    
  end

end

class Play
  include MyObjectStore

  attr_accessor :age, :fname, :lname, :email

  validate_presence_of :fname, :mail

  def validate 
    $validation_list.each do | validation_var |
      if instance_variable_get("@#{ validation_var }") && instance_variable_get("@#{ validation_var }").strip == ''
        instance_variable_set("@#{ validation_var }","Validation not successful" )
        print "Validation not successfull of #{ validation_var } in #{ self }"
        return true
      end
    end
    return false
  end

  def self.method_missing(method_name, *args, &block)
    $user_array.send method_name, *args, &block
  end


end

p2 = Play.new
p2.fname = "" 
p2.lname = "def" 
p2.save  
p3 = Play.new
p3.fname = "alpha" 
p3.lname = "beta" 
p3.save
p4 = Play.new
p4.fname = "alpha" 
p4.lname = "gamma" 
p4.save

Play.find_by_fname("abc").each do |play_object|
  puts play_object.lname
end
Play.find_by_email("abcd")
puts Play.collect { |var| var }
puts Play.count { |var| var.is_a? Array }
puts Play.count { |var| var.is_a? Play }