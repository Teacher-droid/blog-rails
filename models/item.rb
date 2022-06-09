
# Useful includes
# Nothing crazy here so far...

# Item - Class instantiating an Item with its properties
class Item

  attr_accessor :id, :descr, :brand, :unit_price, :quantity
  @@unique_item_counter = 0
  
  def initialize(my_id, my_descr, my_brand = "GibbZ", my_unit_price = 0, my_quantity = 0)
    @id = my_id
    @descr = my_descr
    @brand = my_brand
    @unit_price = my_unit_price
    @quantity = my_quantity
    @@unique_item_counter += 1
  end

end


