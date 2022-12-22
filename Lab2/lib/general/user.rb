class User
    attr_accessor :username, :password, :access_token

    def initialize(username, password, access_token)
        @username = username
        @password = password
        @access_token = access_token
    end
end