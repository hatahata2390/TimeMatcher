class LikeRelationship < ApplicationRecord
# Validation
  validates :like_sender_id,    presence: true
  validates :like_receiver_id,  presence: true
    
# Relation
  belongs_to :like_sender,   class_name: "User"
  belongs_to :like_receiver, class_name: "User"
end
