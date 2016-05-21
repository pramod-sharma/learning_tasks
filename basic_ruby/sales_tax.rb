class Product
  @@list = []
  attr_reader :name, :is_imported, :is_tax_exempted, :price

  def initialize name, is_imported, is_tax_exempted, price
    @name = name
    @is_imported = is_imported
    @is_tax_exempted = is_tax_exempted
    @price = price
    @@list.push self
  end

  def self.list
    @@list
  end

  def gross_cost
    product_cost = @price
    product_cost += ( ( 10 * product_cost ) / 100.0 ) if @is_tax_exempted != "yes"
    product_cost += ( ( 5 * product_cost ) / 100.0 ) if @is_imported == "yes"
    product_cost
  end
end

class Expenditure
  def self.calculate
    expenditure = 0
    Product.list.each do |product|
      product_gross_cost = product.gross_cost
      expenditure += product_gross_cost
    end
    expenditure
  end
end

#Ask for user input and create list
begin
  puts "Enter the name of product"
  name = gets.chomp
  puts "Imported ?"
  is_imported = gets.chomp
  puts "Exempted from sales tax ?"
  is_tax_exempted = gets.chomp
  puts "Enter Price"
  price = gets.chomp.to_i
  Product.new name, is_imported, is_tax_exempted, price
  puts "Do you want to add more item to the list(y/n)?"
  continue_choice = gets.chomp
end while continue_choice =~ /^y$/i


# Find max name field length to display
max_length_product_name = Product.list.max_by { |product| product.name.length }.name
name_field_length = max_length_product_name.length > "Product Name".length ? max_length_product_name.length : "Product Name".length

#Display product details and total expenditure
puts "#{ 'Product Name'.ljust(name_field_length) } | Imported | Tax Exempted | Price"  
Product.list.each do |product|
  puts "#{ product.name.ljust(name_field_length) } | #{ product.is_imported.ljust('Imported'.length) } | #{ product.is_tax_exempted.ljust('Tax Exempted'.length) } | #{ product.price }"
end

expenditure = Expenditure.calculate
puts "Total Expenditure (inclusive of taxes) : #{ expenditure.round(0) }"