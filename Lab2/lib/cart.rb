require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'csv'
require 'json'
require 'yaml'
require './lib//laptop.rb'
require './lib/item.rb'

class Cart

    def save_to_csv()
        path_csv = './rozetka_all.csv'
        laptop = Laptop.get_All()
        #puts "Laptops: ", laptop
        begin  
            File.new(path_csv, "w")
            
            CSV.open(path_csv, "w", headers: ['Id', 'Name', 'Price', 'Availability', 'Rating', 'Description', 'Reviews count'], write_headers: true) do |csv|
                laptop.each do |product|
                    csv << [product.id, product.name, product.price, product.availability, product.rating, product.description, product.reviews_count]
                end
            end

            puts "Successfully writen in the csv file"
        rescue StandardError => e
            puts e.message
            puts "Can not open the csv file for writing"
        end
    end

    def save_to_json()
        path_json = './rozetka_all.json'
        laptop = Laptop.get_All()

        begin 
            File.new(path_json, "w")

            File.open(path_json, "w") do |json|
                laptop.each do |product|
                    temp_hash = {
                        "Id" => product.id,
                        "Name" => product.name,
                        "Price" => product.price,
                        "Availability" => product.availability, 
                        "Rating" => product.rating, 
                        "Description" => product.description,
                        "Reviews count" => product.reviews_count
                    }

                    json.write(JSON.pretty_generate(temp_hash))
                end
            end


            puts "Successfully writen in the json file"
        rescue StandardError => e
            puts e.message
            puts "Can not open the json file for writing"
        end
    end

    def save_to_yml()
        path_yml = "./rozetka_all.yml"
        laptop = Laptop.get_All()
        products = []

        begin
            laptop.each do |product|
                temp_hash = {
                    "Id" => product.id,
                    "Name" => product.name,
                    "Price" => product.price,
                    "Availability" => product.availability, 
                    "Rating" => String(product.rating), 
                    "Description" => product.description,
                    "Reviews count" => product.reviews_count
                }
                products.push(temp_hash)
            end
            File.new(path_yml, "w")

            File.open(path_yml, "w") { |file| file.write(products.to_yaml) }
        
            puts "Successfully writen in the yml file"
        rescue StandardError => e
            puts e.message
            puts "Can not open the yml file for writing"
        end 
    end
end