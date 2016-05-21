module MyModule
  def self.included class_including

    (class << Filter; self; end).class_eval do
      ['before','after'].each do |timing|

        define_method( "#{ timing }_filter" ) do | *args |
          if args.last.is_a? Hash
            if args.last.has_key? :only
              Object.const_set("#{ timing.upcase }_METHOD", args.last[:only] )
            end
            if args.last.has_key? :except
              Object.const_set( "#{ timing.upcase }_METHOD", instance_methods(false) - args.last[:except] )
            end
            args.pop
          else
            Object.const_set("#{ timing.upcase }_METHOD", instance_methods(false) )
          end


          ( Object.const_get( "#{ timing.upcase }_METHOD" ) - args ).each do |method_called|
            alias_method "original_#{ method_called }", "#{ method_called }"

            define_method( "#{ method_called }" ) do | *input |
              
              args.each do | arg_method |
                if timing == 'before' 
                  send arg_method 
                end
              end
              
              send "original_#{ method_called }", *input
              
              args.each do |arg_method|
                if timing == 'after' 
                  send arg_method
                end
              end
            end

          end

        end
      end
    end
  end
end

class Filter
  include MyModule

  def foo
    puts 'foo called'
  end

  def bar
    puts 'bar called'
  end

  def test_method
    puts 'test_method called'
  end
  
  def method1
    puts 'method1 called'
  end

  def method2
    puts 'method2 called'
  end

  def method3
    puts 'method3 called'
  end

  before_filter :foo, :bar, :except => [:method2, :method3]
  after_filter :test_method, :only => [:method2]

end 

filter = Filter.new

filter.method1
puts ''
filter.method2
puts ''
filter.method3
