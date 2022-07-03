
# Useful includes
require_relative '../views/show.rb'
require_relative '../controllers/controller.rb'
require_relative './item.rb'
require 'io/console'

# Shop - Class allowing to instantiate a shop (full of items stored in an array) and to back it up to a CSV file
class Shop

  attr_accessor :name, :stock, :file
  
  def initialize(my_file, my_name = "ToTo' Lair")
    @name = my_name
    @stock = []
    @file = my_file
  end

  # get_next_id - Returns nil if "stock" is empty, the highest "id" of all items in the stock + 1 elseway
  # NB: the "get_last_id" is a private instance method
  def get_next_id
    my_tmp_last_id = self.get_last_id
    return my_tmp_last_id.nil? ? nil : my_tmp_last_id + 1
  end

  # add_item_to_shop - Pushes the given "my_item" item into the "stock" array of the calling "shop"
  # TO DO: adding condition on "my_item" validity (ex. correct if and non-already existing "id", "quantity" > 0...)
  def add_item_to_shop(my_item)
    @stock.push(my_item)
  end

  # get_index_from_item_id - Taking an "item.id", returns its related index (if present) within the "stock" of the current "shop", "nil" elseway
  def get_index_from_item_id(item_id)
    if @stock.empty?
      return nil    
    end
    @stock.each_with_index do |item, index|
      if item.id == item_id
        return index
      end
    end
    return nil
  end

  # get_item_from_item_id - Taking an "item.id", returns the related object (if existing) within the "stock" of the current "shop", "nil" elseway
  def get_item_from_item_id(item_id)
    if @stock.empty?
      return nil    
    end
    @stock.each do |item|
      if item.id == item_id
        return item
      end
    end
    return nil
  end

  # load_from_csv - Open the pointed CSV file (if exists, if not return nil) and return a table containing all the related items
  def load_from_csv
    tmp_file = nil
    tmp_lines_tab = []
    tmp_item_tab = []
    tmp_all_items_tab = []
    tmp_line_counter = 0
    if $verbose
      Show.displn("")
      Show.displn("Reading all items from CSV file:")
      Show.displn("   Searching for the pointed CSV file '#{@file}'.")
    end
    if !File.exists?(@file)
      Show.displn("   Sought CSV file '#{@file}' does not exist, sorry. Hence not able to display any item.") if $verbose
      self.stock = []
      return false
    else
      Show.displn("   CSV file found. Block reading from it.") if $verbose
      tmp_lines_tab = IO.readlines(@file)
      tmp_lines_tab.each do |my_line|
        tmp_item_tab = my_line.split("|")
        tmp_all_items_tab.push(Item.new(tmp_item_tab[0].chomp.to_i,   # id
                                        tmp_item_tab[1].chomp,        # name
                                        tmp_item_tab[2].chomp,        # brand
                                        tmp_item_tab[3].chomp.to_f,   # price      
                                        tmp_item_tab[4].chomp.to_i    # quantity
                                      ))
        tmp_line_counter += 1
      end
      Show.displn("   Read #{tmp_line_counter} line(s) then stored them into 'Shop.stock', an array of Item objects.") if $verbose
      self.stock = tmp_all_items_tab
      return true
    end
  end

  # save_to_csv - Erase and replace the whole file content with the Shop stock
  def save_to_csv()
    if @stock.empty?
      Show.displn("   Stock being desperately empty saving it to backup CSV file '#{@file}' is not a good idea. Aborting...") if $verbose
    else
      if $verbose
        Show.displn("")
        Show.displn("Saving items into CSV file:")
        Show.displn("   Searching for backup file '#{@file}'.")
      end
      if File.exists?(@file)
        Show.displn("   File '#{@file}' exists already  Replacing it with the updated shop content.") if $verbose
      else
        Show.displn("   File '#{@file}' does not exist yet  Creating, opening and writing the gossip into the file.") if $verbose
      end
      my_serialized_stock = ""
      @stock.each do |my_item|
        my_serialized_stock += my_item.serialize + "\n"
      end
      File.write(@file, my_serialized_stock)
      if $verbose
        Show.displn("   Shop data written.")
        Show.displn("   Closing backup file.")
      end
    end
  end

private

  # get_last_id - Return nil if "stock" is empty, the highest "id" of all items in the stock elseway
  # (>--~={ ENCAPSULATION }=~--<)
  def get_last_id
    if @stock.empty?
      return nil
    end
    @stock.sort_by { |obj| obj.id }
    return @stock.last().id
  end

end
