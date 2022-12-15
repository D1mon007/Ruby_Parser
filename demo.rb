require 'csv'
require './Parser.rb'

parser = Parser.new('https://rozetka.com.ua/ua/notebooks/c80004/')


parser.parse()