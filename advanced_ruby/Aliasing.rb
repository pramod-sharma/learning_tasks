module MyModule
  def self.included class_including
    ( class << Hello; self; end ).class_eval do

      def chained_aliasing method_name, method_name_extension
        method_name.match (/^(\w+)([!|?|=])?$/)
        alias_method "#{$1}_without_#{method_name_extension}#{$2}", "#{method_name}"
      
        define_method "#{$1}_with_#{method_name_extension}#{$2}" do
          puts "--logging start"
          send "#{$1}_without_#{method_name_extension}#{$2}"
          puts "--logging end"
        end
        if public_method_defined?("#{method_name}")
          public("#{$1}_with_#{method_name_extension}#{$2}")
        elsif protected_method_defined?("#{method_name}")
          protected("#{$1}_with_#{method_name_extension}#{$2}")
        else
          private("#{$1}_with_#{method_name_extension}#{$2}")
        end
          
        alias_method "#{method_name}", "#{$1}_with_#{method_name_extension}#{$2}"
      end
      
    end
  end
end

class Hello
  include MyModule

  def greet
    puts "greet"
  end

  chained_aliasing :greet, :logger
end

say = Hello.new
say.greet
say.greet_without_logger
puts "Private instance method #{Hello.private_instance_methods(false)}"
puts "Public instance method #{Hello.public_instance_methods(false)}"
puts "Protected instance method #{Hello.protected_instance_methods(false)}"