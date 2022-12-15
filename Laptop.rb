require "./Item.rb"

class Laptop
    @@laptop = []

    def self.set_item(item)
        @@laptop.push(item)
    end

    def self.get_All()
        @@laptop
    end
end
