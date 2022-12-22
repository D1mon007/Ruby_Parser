require 'csv'
require './Parser.rb'
require './Cart.rb'

parser = Parser.new('https://rozetka.com.ua/ua/notebooks/c80004/')

cart = Cart.new()

parser.parse()
cart.save_to_csv()
cart.save_to_json()
