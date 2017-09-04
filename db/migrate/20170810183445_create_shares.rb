class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.integer :album_id

      t.timestamps
    end
  end
end
