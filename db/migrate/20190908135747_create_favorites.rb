class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :owner_user_id
      t.integer :favorite_user_id

      t.timestamps
    end
    add_index :favorites, :owner_user_id
    add_index :favorites, :favorite_user_id
    add_index :favorites, [:owner_user_id, :favorite_user_id], unique: true  
  end
end
