
# Useful includes & requires
require 'bundler'
Bundler.require
require_relative './routers/router.rb'

# Defines the data location

# Launches the whole program logic by invoking the perform method on the newly created Router object
Router.new.perform


