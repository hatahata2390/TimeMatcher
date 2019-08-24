class Room < ApplicationRecord
# Relation
  has_many :messages,
            dependent:   :destroy
  has_many :user_room_relationships,
            dependent:   :destroy
  has_many :users, through: :user_room_relationships
end