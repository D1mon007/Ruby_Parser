module Validators
    class IntegerValidator
        def self.check_if_min_max(min, max)
            lambda do |v|
                is_float = !!(Float(v) rescue false)
                if !is_float
                    return false
                end
                number = Float(v)
                number and (number >= min) and (number <= max)
            end
        end
    end
end