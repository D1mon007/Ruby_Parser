require 'open-uri'
require 'byebug'
require 'nokogiri'
require './Laptop.rb'
require './Item.rb'

class Parser

    def initialize(url)
        @url = url
    end

    def parse()
        begin
            html = URI.open(@url) { |result| result.read}
            doc = Nokogiri::HTML(html)
            i = 0
            doc.css('.goods-tile__inner').each do |element|
                arr = element.css(".goods-tile__title").text.split(" ")[0, 2]
                str = arr[0] + " " + arr[1]
                laptop = Item.new()
                laptop.name = str
                laptop.description = element.css(".goods-tile__title").text
                laptop.price = element.css(".goods-tile__price-value").text
                laptop.availability = element.css(".goods-tile__availability").text
                laptop.rating = element.css(".goods-tile__stars").at("svg").attribute("aria-label")
                laptop.reviews_count = element.css(".goods-tile__stars").text
                laptop.id = i + 1
                i = i + 1 
                Laptop.set_item(laptop)
            end
        rescue OpenURI::HTTPError => e
            puts e.message
        end
    end
end
