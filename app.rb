
# Useful includes & requires
require 'bundler'
Bundler.require
require_relative './routers/router.rb'

# global variable
$csv = './data/shop.csv'
$verbose = true
$shop_name = 'ToTo\' Lair'
$admin_pwd = '1234'   # Would obviously gain to be encrypted and stored in / accessed from a '.env' file or variable in a future version

# Launches the whole program logic
Router.new.perform


