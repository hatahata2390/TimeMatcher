class CreateUserRoomRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_room_relationships do |t|
      t.references  :user, index: true, foreign_key: true
      t.references  :room, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
