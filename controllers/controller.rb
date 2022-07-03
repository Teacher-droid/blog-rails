# controller.rb 


# Useful includes
require_relative '../views/show.rb'
require_relative '../models/shop.rb'

# Controller - Class managing all the program logic and mechanics
class Controller

  attr_accessor :shop

  # new - Creator of a Controller object
  def initialize(my_csv_file)
    if File.exists?(my_csv_file)
      @shop = Shop.new(my_csv_file, $shop_name)
      if @shop.load_from_csv()
        Show.displn("   Shop successfully created and loaded from CSV file '#{my_csv_file}'!") if $verbose
      else 
        Show.displn("   I'm afraid something went wrong when trying to load the shop with file '#{my_csv_file}'... Shop remains empty.") if $verbose
        @shop = []
      end
    else
      @shop = []
      Show.displn("   I'm sorry but the backup CSV file you're looking for does not seem to exist... Please, try again!") if $verbose
    end
  end

  def check_and_route_admin
    trials = 3
    is_admin_with_valid_pwd = false
    stop_asking = false
    while !stop_asking
      is_admin_with_valid_pwd = self.check_admin_password
      trials -= 1
      stop_asking = is_admin_with_valid_pwd || trials == 0
    end
    if !is_admin_with_valid_pwd
      Show.displn("")
      Show.displn("   Repeated unauthorized connection attempts have been logged and Administrator has been informed ")
    end
    return is_admin_with_valid_pwd
  end

  # check_admin - Handle ADMIN password verification
  def check_admin_password
    return Show.prompt_for_admin_password == $admin_pwd
  end

  # shop_index - Method listing all existing items within a given shop
  def shop_index
    if @shop.stock.empty?
      Show.displn("   Sadly, the shop stock seems... Totally empty. Try storing some items before asking for inventory, maybe?")
      Show.pause
      return false
    end
    Show.list_items(@shop.stock)
    return true
  end

  # item_show - Method displaying all detailed informations of a given item
  def item_show(item_id)
    if @shop.stock.empty? 
      Show.displn("   I'm really sorry but the shop being more than empty, I cannot satisfy your request to see a specific item so far.")
      Show.pause
      return false
    end
    if @shop.get_item_from_item_id(item_id).nil?
      Show.displn("   I'm afraid but the given item ID does not seem to match any of our merchandise.")
      Show.pause
      return false
    end
    Show.show_item(@shop.get_item_from_item_id(item_id))
    return true
  end

  # item_create - Method instantiating a new item in the stock (instance array var) of the shop
  # then saving the updated shop to the backup CSV file
  def item_create
    my_tmp_tab = Show.input_new_item
    my_tmp_id = @shop.get_next_id 
    my_tmp_tab[0] = my_tmp_id.nil? ? 0 : my_tmp_id
    my_item = Item.new(my_tmp_tab[0],    # id
                       my_tmp_tab[1],    # name
                       my_tmp_tab[2],    # brand
                       my_tmp_tab[3],    # unit_price
                       my_tmp_tab[4])    # my_quantity
    @shop.add_item_to_shop(my_item)
    @shop.save_to_csv
  end

  # item_update - Method updating a given item in the stock (instance array) of the shop
  # then saving the updated shop to the backup CSV file
  def item_update(item_id)
    my_item_index = @shop.get_index_from_item_id(item_id)
    if my_item_index.nil?
      Show.displn("   As unlikedly as it can seem, I cannot satisfy your request because the provided item ID does not exist.")
      Show.pause
    else
      my_tmp_tab = Show.input_update_item
      @shop.stock[my_item_index].name = my_tmp_tab[1]
      @shop.stock[my_item_index].brand = my_tmp_tab[2]
      @shop.stock[my_item_index].unit_price = my_tmp_tab[3]
      @shop.stock[my_item_index].quantity = my_tmp_tab[4]
      Show.displn("   Item with ID '#{item_id}' has been updated successully.")
      @shop.save_to_csv
    end
  end

  # item_delete - Method deleting the given item in the stock (instance array) of the shop
  # TO DO: cf. below
  def item_delete(item_id)
    if Show.confirm_item_deletion_menu(item_id)
      @shop.stock = @shop.stock.reject { |obj| obj.id == item_id }
      Show.displn("  ✔️ Item '#{item_id}' erased from inventory.")
      # TO DO: instantly saves the updated shop into the CSV file or delay this task ?
    else
      Show.displn("   Deletion of item '#{item_id}' cancelled by user.")
    end
  end

end
