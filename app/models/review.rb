class Review < ApplicationRecord
    # Each review belongs to a game and a user
    belongs_to :game
    belongs_to :user
end
