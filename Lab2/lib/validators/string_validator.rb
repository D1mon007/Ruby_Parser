module Validators
    class StringValidator
        def self.check_if_starts_with(line)
            -> (v) { v.start_with? line}
        end
    end
end