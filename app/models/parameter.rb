class Parameter < ApplicationRecord
    def self.value_for(key)
        find_by(key: key)&.value
    end
end
