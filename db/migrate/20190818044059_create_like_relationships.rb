class CreateLikeRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :like_relationships do |t|
      t.integer :like_sender_id
      t.integer :like_receiver_id

      t.timestamps
    end
    add_index :like_relationships, :like_sender_id
    add_index :like_relationships, :like_receiver_id
    add_index :like_relationships, [:like_sender_id, :like_receiver_id], unique: true  
  end
end
