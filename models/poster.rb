# Useful includes
require_relative './item.rb'

# Poster - Sub-class of Item 
# (>--~={ INHERITANCE }=~--<)
class Poster < Item

  attr_accessor :size
  @@unique_poster_counter = 0
  @@valid_sizes = ["A2","A1","A0"]
  
  def initialize(poster_id, poster_name, poster_brand = "ToTo", poster_unit_price = 0.0, poster_quantity = 1, poster_size)
    super(poster_id, poster_name, poster_brand, poster_unit_price, poster_quantity)
    @size = check_format(poster_size)
    @@unique_poster_counter += 1
  end

  # Display all poster information 
  # (>--~={ POLYMORPHISM }=~--<)
  def disp_info_long
    Show.displn("  > Item ID: #{@id} - Name: #{@name} - Brand : #{@brand} - Size: #{@size} - Price: #{@unit_price}€ - Quantity: #{self.humanize_quantity}")
  end

  # Serializes (i.e. flatten and stringify complex object type) all poster information to be written into CSV file 
  # (>--~={ POLYMORPHISM }=~--<)
  def serialize
    return "#{@id}|#{@name}|#{@brand}|#{@unit_price}|#{@quantity}|#{@size}"
  end

  private

  # Verify the given format of the poster is within valid range
  # (>--~={ ENCAPSULATION }=~--<)
  def self.check_format(my_format)
    if @@valid_sizes.include?(my_format) 
      return my_format
    end
    default_format = @@valid_sizes[0]
    Show.displn("  > The given format of the poster being created appeared to be invalid. Defaulting it to '#{default_format}'")
    return default_format
  end

end
