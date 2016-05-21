class Vehicle
  attr_writer :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name : #@name price : #@price"
  end
end

class Bike < Vehicle
  def initialize(name, price, dealer)
    super(name, price)
    @dealer = dealer
  end

  def to_s
    super + " dealer : #@dealer"
  end
end
new_bike = Bike.new('yamaha', 1213, "tamang")
puts new_bike.to_s
new_bike.price = 1990
puts new_bike.to_s