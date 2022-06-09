# router.rb 

# Useful includes
require_relative '../controllers/controller.rb'
require_relative '../views/show.rb'

# Router - Class branching the user to the relevant Controllers and/or Views to enable interacting wit the Model #mvcpowaa
class Router

  attr_accessor :controller

  def initialize
    @controller = Controller.new($csv)
  end 

  # This is where all the routing magic happens... 
  def perform 
    tmp_prompt = []
    tmp_gossip_id = 0
    tmp_route = false
    exit = false
    Show.displn("");
    Show.displn("");
    Show.displn("--~={ !! Welcome to #{@controller.shop.name} !! }=~--")
    while !exit
      choice = Show.main_menu
      case choice
      when 1 # READ all stored gossips
        Show.displn("You decided to have a look at our shop's stock: let's do it!")
        tmp_route = @controller.shop_index
      when 2 # CREATE a new item
        # Show.displn("You chose to store a new gossip. Cool!")
        # tmp_prompt = Show.input_gossip
        # @controller.create_gossip(tmp_prompt[0], tmp_prompt[1])
      when 3 # UPDATE an existing item
        Show.displn("Hey, you! The UPDATE feature for our items is still WIP. Keep calm, lay back and eat a pizza instead.")
      when 4 # DELETE a given gossip
        Show.displn("Hey, you! The DELETE feature for our items is still WIP. Have a beer and come back later.")
        # Show.displn("Yo, Stranger! This feature is not for lamerz... Be careful with what you do to my gossip list, OK?")
        # Show.displn("")
        # tmp_route = @controller.index_gossips
        # if tmp_route
        #   tmp_gossip_id = Show.prompt_for_deletion
        #   if @controller.delete_gossip(tmp_gossip_id)
        #     Show.displn("Nicely done, Stranger! Looks like gossip ##{tmp_gossip_id} has been deleted. Surely telling unmentionable things about you ;-)")
        #     Show.pause
        #   else
        #     Show.displn("Oooops! Looks like something went wrong... Next time, ask your 3-year-old brother or sister for help, Stranger.")
        #     Show.pause
        #   end
        # else
        #   Show.displn("Looks like the Gossip file is still empty: no mean to delete from it, then... You fool :-D")
        #   Show.pause
        # end
      when 5
        Show.displn("")
        Show.displn("--~={ !! Goodbye... Hope to see you (not too) soon, Stranger !! }=~--")
        Show.displn("")
        exit = true
      else
        Show.displn("/!\\ You apparently encountered difficulties typing an adequate choice... Ask your dog or cat for help, dumb ass ;-)")
      end
    end
  end
end


