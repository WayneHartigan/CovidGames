class Category < ApplicationRecord
    # Each category can have many games attached to it
    has_many :games
end
