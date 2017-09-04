class AddImgToPhotos < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :photos, :img
  end

  def self.down
    remove_attachment :photos, :img
  end
end
