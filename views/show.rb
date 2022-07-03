
# Useful includes
# Nothing crazy here as Show is more of a static / abstract class than a standard one #abstraction ;-)

# Show - Class enabling most display-related work within the application complying with the MVC approach
class Show

  # clrscr - Static method flushing the screen using the Xterm command 'clear'
  # WARNING: 'clear' does not exist on all OSs, hence this code is not fully portable
  def self.clrscr
    system('clear')
  end

  # disp - Static method displaying the 'message' content to the STDIN (DISPLAY:0) *without* a "\n" (line feed)
  # OK, this is just an alias for the Ruby standard command "print" but, hey, it's 100% OOP now 
  # and keeps more consistent than the usual "print" and "puts" ruby commands!
  def self.disp(message) 
    print message
  end

  # displn - Static method displaying the 'message' content to the STDIN (DISPLAY:0) *with* a "\n" (line feed)
  def self.displn(message) 
    puts message
  end

  # pause - Static method inserting a 'pause' by forcing the user to press the [Return] key (or any other in fact) for the program to continue
  def self.pause
    displn("")
    displn(" ...Press [Return] to continue... ")
    displn("")
    gets
  end

  # welcome - Static method displaying the shop splash screen
  def self.welcome(shop_name)
    displn("\n--~={ !! Welcome to #{shop_name} !! }=~--")
    displn("")
  end

  # goodbye - Static method displaying the shop exit message
  def self.goodbye(shop_name)
    displn("")
    displn("")
    displn("--~={  Goodbye... Hope to see you soon again at #{shop_name}  }=~--")
    displn("")
  end

  # heading - Static method displaying a section heading
  def self.heading(my_heading)
    displn("")
    displn("[ #{my_heading} ]")
    displn("")
  end

  # main_menu - Static method displaying the main ADMIN menu
  def self.main_menu
    heading(" MAIN MENU ")
    displn("  1) I am a client")
    displn("  2) I am the administrator")
    displn("  3) I want to leave all this consumerism behind me, now! (EXIT)")
    displn("")
    disp("  ? ")
    return gets.chomp.to_i
  end

  # main_menu_admin - Static method displaying the main ADMIN menu
  def self.main_menu_admin
    heading(" ADMIN MAIN MENU ")
    displn("  1) List all existing items in the shop (READ)")
    displn("  2) Add a new item to the shop (CREATE)")
    displn("  3) Go back to main menu of the shop (BACK)")
    displn("")
    disp("  ? ")
    return gets.chomp.to_i
  end

  # list_items - Static looping display method showing ID and NAME only of each item sold in the shop
  def self.list_items(items_tab)
    tmp_count = 0
    heading(" SHOP INVENTORY ")
    items_tab.each do |item|
      item.disp_info_short
      tmp_count += 1
    end
    displn("")
    displn("  >> #{tmp_count} item type(s) listed.")
  end

  # select_item_menu - Static method allowing to (Q)uit to main menu or to select which item (id) to display the detail information of
  def self.select_item_menu
    heading(" ITEM SELECTION MENU ")
    displn("   Type in the ID of the item whose detailed information you want to display")
    displn("   Enter '0' (zero) to get back to the main menu")
    displn("")
    disp("  ? ")
    return gets.chomp.to_i
  end

  # show_item - Static method showing ID, NAME, BRAND, UNIT PRICE and QUANTITY of all items in the Shop
  def self.show_item(item)
    if item.nil?
      displn("")
      displn("  Seems like the item you chose does not exist (value is 'nil')")
      displn("")
    else
      heading(" ITEM DETAILED INFORMATION ")
      item.disp_info_long
      displn("")
    end
  end

  # item_actions_menu - Static method displaying the item management menu
  def self.item_actions_menu
    heading(" ITEM MANAGEMENT MENU ")
    displn("  1) Modify item information (UPDATE)")
    displn("  2) Suppress item from shop (DELETE)")
    displn("  3) Go back to shop inventory (BACK)")
    displn("")
    disp("  ? ")
    return gets.chomp.to_i
  end

  # input_new_item - Static method prompting the user for the NEW item characteristics, then returning them in a single array
  # NB: might gain from encapsuling this into each item type then specializing it #polymorphism
  # Reminder: Basic item > id, name, brand, unit_price, quantity
  def self.input_new_item
    heading(" ITEM CREATION ")
    displn("  To input a new item into our stock, please enter its characteristics hereby:")
    return input_item
  end

  # input_update_item - Static method prompting the user for the characteristics of the item to be UPDATED, then returning them in a single array
  # NB: might gain from encapsuling this into each item type then specializing it #polymorphism
  # Reminder: Basic item > id, name, brand, unit_price, quantity
  def self.input_update_item
    heading(" ITEM UPDATE ")
    displn("  To update this item's characteristics, please enter the new values here below:")
    return input_item
  end

  # input_item - Static method prompting the user for the characteristics of an item to be CREATED or UPDATED, then returning them in a single array
  # NB: might gain from encapsuling this into each item type then specializing it #polymorphism
  # Reminder: Basic item > id, name, brand, unit_price, quantity
  def self.input_item
    tmp_tab = [0,"","",0.0,0]
    while tmp_tab[1].length < 3 || tmp_tab[1].length > 50
      disp("  > Name (3 to 50 characters) ? ")
      tmp_tab[1] = gets.chomp
    end
    while tmp_tab[2].length < 3 || tmp_tab[2].length > 50
      disp("  > Brand (3 to 50 character) ? ")
      tmp_tab[2] = gets.chomp
    end
    while tmp_tab[3] <= 0.0
      disp("  > Unit price (greater than 0, use '.' as decimal separator) ? ")
      tmp_tab[3] = gets.chomp.to_f
    end
    while tmp_tab[4] <= 0
      disp("  > Quantity (greater than 0) ? ")
      tmp_tab[4] = gets.chomp.to_i
    end
    return tmp_tab
  end

  # confirm_item_deletion_menu - Once the details of an item displayed and the "delete" option chosen
  # fires an ultimate security confirmation message ("Y/y" force deletion, anything else aborts it)
  def self.confirm_item_deletion_menu(item_id)
    heading(" ITEM DELETION CONFIRMATION MENU ")
    displn("  > Do you confirm you actually and definitively want to delete the item with ID '#{item_id}' (Y/N)?")
    disp("     ? ")
    return (gets.chomp.upcase == "Y")
  end

  # menu_input_error_message - Factorization and simplification of a recurring error message display
  # (>--~={ ABSTRACTION / FACTORIZATION }=~--<)
  def self.menu_input_error_message
    displn(" You apparently encountered difficulties typing an adequate choice... Please try again ")
  end

  # prompt_for_admin_password - Prompt for a password before allowing to access ADMIN main menu
  def self.prompt_for_admin_password
    heading(" ADMIN CONNEXION MENU ")
    displn("  > Please enter your administrator password below.")
    disp("     ? ")
    return (gets.chomp)
  end

end
