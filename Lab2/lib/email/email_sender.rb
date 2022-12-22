require_relative '../general/user.rb'
require 'dotenv/load'
require 'nylas'

module Email
    class EmailSender
        def initialize
            @credentials = EmailCredentials.get_email_credentials
            @nylas = Nylas::API.new(
                app_id: @credentials.username,
                app_secret: @credentials.password,
                access_token: @credentials.access_token)
        end

        def add_file(file)
            @file = @nylas.files.create(file: File.open(File.expand_path(file.filepath), 'r')).to_h
        end

        def send(to, name, subject, body)
            @nylas.send!(
                to: [{ email: to, name: name }],
                subject: subject,
                body: body,
                file_ids: [@file[:id]]
                ).to_h
        end
    end
end