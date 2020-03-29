class Game < ApplicationRecord
    # Each game belongs to a user and a category(genre)
    belongs_to :user
    belongs_to :category
    # Each game can have many reviews
    has_many :reviews

    # Set up for paperclip to allow images to be saved to a game
    has_attached_file :game_img, styles: { game_index: "250x350>", game_show: "325x475>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :game_img, content_type: /\Aimage\/.*\z/
end
