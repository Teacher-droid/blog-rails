
# Useful includes
# None

# Item - Class instantiating an Item with its properties
class Item

  attr_accessor :id, :name, :brand, :unit_price, :quantity
  @@unique_item_counter = 0

  def initialize(my_id, my_name, my_brand = "ToTo", my_unit_price = 0.0, my_quantity = 1)
    @id = my_id
    @name = my_name
    @brand = my_brand
    @unit_price = my_unit_price
    @quantity = my_quantity
    @@unique_item_counter += 1
  end

  # Displays synthetic item information (superclass method also used by subclasses such as "Shoes")
  def disp_info_short
    Show.displn("  > Item ID: #{@id} - Name: #{@name}")
  end

  # Display all item information (method overridden by sub-class, such as Shoes, to enable adding extra characteristics, such as "size" for Shoes)
  def disp_info_long
    Show.displn("  > Item ID: #{@id} - Name: #{@name} - Brand : #{@brand} - Price: #{@unit_price}€ - Quantity: #{self.humanize_quantity}")
  end

  # Serializes (i.e. flatten and stringify complex object type) all item information to be written into CSV file (method overridden by sub-classes)
  def serialize
    return "#{@id}|#{@name}|#{@brand}|#{@unit_price}|#{@quantity}"
  end

  private

  # enable to "humanize" the "0 quantity" value, notably when printing info to screen
  # (>--~={ ENCAPSULATION }=~--<) + (>--~={ ABSTRACTION }=~--<)
  def humanize_quantity
    @quantity == 0 ? "Out of stock" : @quantity.to_s
  end

end


