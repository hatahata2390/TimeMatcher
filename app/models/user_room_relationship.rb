class UserRoomRelationship < ApplicationRecord
# Validation
  validates :user,  presence: true
  validates :room,  presence: true
  
# Relation
  belongs_to :user
  belongs_to :room
end