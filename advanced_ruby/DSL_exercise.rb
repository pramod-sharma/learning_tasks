class ShoppingList
  attr_reader :list
  
  def initialize
    @list = []
  end

  def items( &block )
    instance_eval( &block )
  end

  def add product_details
    @list.push Product.new( product_details[:name], product_details[:quantity] )
  end
end

class Product
  def initialize name, quantity
    @name = name
    @quantity = quantity
  end
end

shopping_list = ShoppingList.new
shopping_list.items do
  add( { :name => "Toothpaste", :quantity => 2 } )
  add( { :name => "Computer", :quanity => 1 } )
end
puts shopping_list.list.inspect