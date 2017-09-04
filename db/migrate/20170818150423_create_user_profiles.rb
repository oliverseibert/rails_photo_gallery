class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :city
      t.string :zipcode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
