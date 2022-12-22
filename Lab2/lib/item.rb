class Item
    attr_accessor :id, :name, :price, :availability, :rating, :description, :reviews_count

    def initialize(id = 0, name ='', price = 0, availability = '', rating = '', description = '', reviews_count = '')
        @id = id
        @name = name
        @price = price
        @availability = availability
        @rating = rating
        @description = description
        @reviews_count = reviews_count
    end

    def to_s()
        "id=#@id, name=#@name, price=#@price, availability=#@availability,
        rating=#@rating, description=#@description, reviews_count=#@reviews_count"
    end

    def to_h()
        {'id' => @id, 'name'=> @name, 'price' => @price, 
            'availability' => @availability, 'rating' => @rating, 'description' => @description, 'reviews_count' => @reviews_count}
    end

    def info(block)
        @info = block
    end

end
