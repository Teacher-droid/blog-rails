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
      @shop = Shop.new(my_csv_file)
      if @shop.load_from_csv()
        Show.disp("  > Shop successfully created and loaded from CSV file '#{my_csv_file}'!")
      else 
        Show.disp("  > I'm afraid something went wrong when trying to load the shop with file '#{my_csv_file}'... Shop remains empty.")
        @shop = []
      end
    else
      @shop = []
      Show.disp("  > I'm sorry but the backup CSV file you're looking for does not seem to exist... Try again, Stranger!")
    end
  end

  # shop_index - Method listing all existing items within a given shop
  def shop_index
    if @shop.stock != []
      return true
    else
      Show.disp("  > Sadly, the shop stock is... Totally empty. Try storing some items before asking for inventory, dumbroad!")
      Show.pause
      return false
    end
  end

  # item_show - Method displaying all detailed informations of a given item
  def item_show(item)
    if @shop.stock != [] 

      Show.show_item(item)
      return true
    else
      Show.disp("  > I'm really sorry but the shop being more than empty. I cannot satisfy your request to see")
      Show.pause
      return false
    end
  end

  # create_item - Method instantiating a new gossip object accessible by the Controller
  # def create_item(the_author,the_gossip)
  #   my_gossip = Gossip.new(the_author,the_gossip,0,true)
  #   my_gossip.save_to_csv(@csv)
  # end

  # delete_gossip - Launch the Gossip class method 'suppr_gossip_from_csv' to defintively delete the Gossip with given 'id'
  # def delete_gossip(my_gossip_id)
  #   return Gossip.suppr_gossip_from_CSV(@csv, my_gossip_id)
  # end

end


