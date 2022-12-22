require './lib/validators/integer_validator.rb'
require './lib/validators/string_validator.rb'
require './lib/converters/integer_converters.rb'
require './lib/infrastructure/input_reader.rb'
require './lib/email/email_credentials.rb'

require './lib/engine.rb'

module MyApplicationHolovachMadey
    class Application
        def initialize
            @reporting_email = "herous2001@gmail.com"
        end

        def run
            input_reader = InputReader.new
            
            catalogue_link = input_reader.read(
                "Input Rozetka web page link", -> (v) { v },
                Validators::StringValidator.check_if_starts_with("https://rozetka.com.ua"),
                "Incorrect link to Rozetka!"
            )
            
            #catalogue_link = "https://rozetka.com.ua/ua/mobile-phones/c80003/"

            number_of_pages = input_reader.read(
                "Input pages count for parsing [1-50]",
                Converters::IntegerConverters.get_convert_to_number_lambda,
                Validators::IntegerValidator.check_if_min_max(1, 60),
                "Incorrect number!"
            )

            engine = Engine.new(catalogue_link, EmailCredentials.get_email_credentials, @reporting_email)

            engine.perform_parsing(number_of_pages)
        end
    end
end