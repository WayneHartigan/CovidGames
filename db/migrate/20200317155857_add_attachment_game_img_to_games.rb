class AddAttachmentGameImgToGames < ActiveRecord::Migration[5.2]
  def self.up
    change_table :games do |t|
      t.attachment :game_img
    end
  end

  def self.down
    remove_attachment :games, :game_img
  end
end
