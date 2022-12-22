require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'rubygems'
require 'mechanize'
require './lib/laptop.rb'
require './lib/item.rb'

class Parser
    def parse_catalogue_page(catalogue_link)
        puts "Parsing catalogue link #{catalogue_link}"
        agent = Mechanize.new
        page = agent.get(catalogue_link)
        product_links = page.links_with(:href => %r{products/}, :class => "h3" )

        product_links.map { |l| "#{page.uri.scheme}://#{page.uri.host}/#{l.uri}" }
    end

    def parse_product_page(product_link, num)
        puts "Parsing product #{product_link}"

        agent = Mechanize.new
        page = agent.get(product_link)
        
        id = num
        name = page.search("//div[@class='goods-tile__title']").text
        puts name
        description = page.search("//div[@class='goods-tile__title']").text
        price = page.search("//div[@class='goods-tile__price-value']").text
        availability = page.search("//div[@class='goods-tile__availability']").text
        reviews_count = page.search("//div[@class='goods-tile__stars']").text

        Item.new(id, name, description, price, availability, 0, reviews_count)
    end


    def initialize(i = 0)
       @i = i
    end

    def parse(page_link, num)
        products = []
        begin
            link = String(page_link)
            puts link
            html = URI.open(link) { |result| result.read}
            doc = Nokogiri::HTML(html)
            #i = num
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
                laptop.id = @i + 1
                @i = @i + 1 
                #puts laptop
                #products.push(laptop)
                Laptop.set_item(laptop)
            end
        rescue OpenURI::HTTPError => e
            puts e.message
        end
    end
end
