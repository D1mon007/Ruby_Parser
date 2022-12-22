require_relative './infrastructure/parser.rb'
require_relative './cart.rb'
require_relative './item.rb'
require_relative './infrastructure/zipper.rb'
require_relative './infrastructure/file_helper.rb'
require_relative './email/email_sender.rb'
require_relative './email/email_attachment.rb'

class Engine
    def initialize(web_address, email_credentials, email_to_send)
        @web_address = web_address
        @email_credentials = email_credentials
        @email_to_send = email_to_send

        @number_of_threads_to_use = 3
    end 

    def perform_parsing(number_of_pages)
        parser = Parser.new

        pages = (1..number_of_pages).to_a.map { |i| "#{@web_address}page=#{i}/" }
        
        products = []
        threads = []
        pages.each do |page|
            threads << Thread.new { parser.parse(page, products.length()) }
        end
        
        products += threads.map(&:value)

        cart = Cart.new
        cart.save_to_csv()
        cart.save_to_json()
        cart.save_to_yml()

        random_suffix = DateTime.now.strftime("%N")

        zipper = Zipper.new("./", "application-#{random_suffix}.zip", [".rb", ".csv", ".json", ".yml"])
        zipper.write

        email_sender = Email::EmailSender.new
        email_attachment = Email::EmailAttachment.new("application-#{random_suffix}.zip", "application-#{random_suffix}.zip")
        email_sender.add_file(email_attachment)
        email_sender.send(@email_to_send, "", "Parser Lab 501 - Ruby - Holovach Madei", "In this email you can find the application code and parsing results. Please see the attachment.")
    end
end